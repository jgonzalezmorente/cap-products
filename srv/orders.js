const cds = require('@sap/cds');
const { Orders } = cds.entities('com.training');

module.exports = (srv) => {
    srv.before('*', (req) => {
        console.log(`Method: ${ req.method }`);
        console.log(`Target: ${ req.target }`);
    });

    // ********** READ ********** //
    srv.on('READ', 'Orders', async (req) => {
        if (req.data.ClientEmail != undefined) {
            return await SELECT.from`com.training.Orders`.where`ClientEmail = ${req.data.ClientEmail}`;
        }
        return await SELECT.from(Orders);
    });

    srv.after('READ', 'Orders', (data) => {
        return data.forEach(order => order.Reviewed = true)
    });

    // ********** CREATE ********** //    
    srv.on('CREATE', 'Orders', async (req) => {
        try {
            const created = await cds.transaction(req).run(
                INSERT.into(Orders).entries({
                    ClientEmail: req.data.ClientEmail,
                    FirstName: req.data.FirstName,
                    LastName: req.data.LastName,
                    CreatedOn: req.data.CreatedOn,
                    Reviewed: req.data.Reviewed,
                    Approved: req.data.Approved
                })
            );

            console.log(created);
            return req.data;
        } catch (error) {
            console.error(error);
            req.error(error.code || 500, error.message || 'Error inesperado al crear el pedido');
        }
    });

    srv.before('CREATE', 'Orders', (req) => {
        req.data.CreatedOn = new Date().toISOString().slice(0, 10);
        return req;
    });

    // ********** UPDATE ********** //
    srv.on('UPDATE', 'Orders', async (req) => {
        try {
            const updated = await cds.transaction(req).run(
                UPDATE(Orders, req.data.ClientEmail).set({
                    FirstName: req.data.FirstName,
                    LastName: req.data.LastName
                })
            );
            if (!updated) {
                req.error(409, 'Record Not Found');
            }
        } catch (error) {
            console.log(error);
            req.error(error.code || 500, error.message || 'Error inesperado al crear el pedido');
        }
    });

    // ********** DELETE ********** //
    srv.on('DELETE', 'Orders', async (req) => {
        try {
            const deleted = await cds.transaction(req).run(
                DELETE.from(Orders).where({
                    ClientEmail: req.data.ClientEmail
                })
            );
            console.log({ deleted });
            if (!deleted) {
                req.error(409, 'Record Not Found');
            }
            return deleted;
        } catch (error) {
            console.log({ error });
            req.error(error.code || 500, error.message || 'Error inesperado al crear el pedido');
        }
    });

    // ********** FUNCTION ********** //
    srv.on('getClientTaxRate', async (req) => {
        console.log(req.params);
        // NO server side-effect        
        const { clientEmail } = req.data;
        const db = cds.tx(req);        
        const results = await db.read(Orders, ['Country_code'])
            .where({ ClientEmail: clientEmail });
        console.log(results);
        const [{ Country_code }] = results;
        switch (Country_code) {
            case 'ES':
                return 21.5;
            case 'UK':
                return 24.6;
            default:
                break;
        }
    });

    // ********** ACTION ********** //
    srv.on('cancelOrder', async (req) => {
        const { clientEmail } = req.data;
        const db = cds.tx(req);

        console.log({ clientEmail });

        const resultsRead = await db.read(Orders, ['FirstName', 'LastName', 'Approved'])
            .where({ ClientEmail: clientEmail });

        console.log({ resultsRead });

        let returnOrder = {
            status: '',
            message: ''
        };

        const [{ FirstName, LastName, Approved }] = resultsRead;
        if (Approved) {
            returnOrder.status = 'Fail';
            returnOrder.message = `The Order placed by ${ FirstName } ${ LastName } was NOT cancelled because was ready approved`;
        } else {
            const resultsUpdate = await db.update(Orders)
                .set({ Status: 'C' })
                .where({ ClientEmail: clientEmail });
            returnOrder.status = 'Succeeded';
            returnOrder.message = `The Order placed by ${ FirstName } ${ LastName } was cancel`;
            console.log({resultsUpdate});
        }
        console.log('Action cancelOrder executed');
        return returnOrder;
    });

};
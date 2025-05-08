const cds = require('@sap/cds');
const { Orders } = cds.entities('com.training');

module.exports = (srv) => {
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
            console.log({deleted});
            if (!deleted) {
                req.error(409, 'Record Not Found');
            }
            return deleted;
        } catch (error) {
            console.log({error});
            req.error(error.code || 500, error.message || 'Error inesperado al crear el pedido');
        }
    });
};
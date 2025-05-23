const cds = require('@sap/cds');

// module.exports = cds.service.impl(async function(srv) {
//     const { Incidents } = srv.entities;
//     const sapbackend = await cds.connect.to('sapbackend');
//     srv.on('READ', Incidents, async (req) => {
//         return await sapbackend.tx(req).send({
//             query: req.query,
//             headers: {
//                 'Authorization': 'Basic c2FwdWk1OnNhcHVpNQ=='
//             }
//         });
//     });
// });

module.exports = async (srv) => {
    const sapbackend = await cds.connect.to('sapbackend');
    const { Incidents } = srv.entities;

    srv.on(['READ'], Incidents, async (req) => {
        let incidentsQuery = SELECT.from(
            req.query.SELECT.from
        ).limit(
            req.query.SELECT.limit
        );
        if (req.query.SELECT.where)
            incidentsQuery.where(
                req.query.SELECT.where
            );
        if (req.query.SELECT.orderBy)
            incidentsQuery.orderBy(req.query.SELECT.orderBy);
        let incident = await sapbackend.tx(req).send({
            query: incidentsQuery,
            headers: {
                'Authorization': `${process.env.SAP_GATEWAY_AUTH}`
            }
        });
        let incidents = [];
        if (Array.isArray(incident)) {
            incidents = incident;
        } else {
            incidents.push(incident);
        }
        return incidents;
    });

};
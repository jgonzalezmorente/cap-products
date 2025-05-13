using { sapbackend as external } from './external/sapbackend';

@protocol: 'graphql'
define service SAPBackendExit {
    @cds.persistence : {
        table,
        skip: false
    }
    @cds.autoexpose
    // entity Incidents as select from external.IncidentsSet;
    entity Incidents as projection on external.IncidentsSet;
}

@protocol: ['rest', 'graphql']
service RestService {
    entity Incidents as projection on SAPBackendExit.Incidents;
}
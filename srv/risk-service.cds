using {riskmanagement as rm} from '../db/schema';

@imp: './handlers/risk-service.js'
@path: 'service/risk'
service RiskService {
    entity Risks  @(restrict :[
        {
            grant: 'READ',
            to : 'RiskViewer'
        },
        {
            grant : [
                'READ',
                'WRITE',
                'UPDATE',
                'UPSERT',
                'DELETE'
            ], //Allpwinf CDS events by explicity mentioning them
            to : 'RiskManager'
        }
    ])      as projection on rm.Risks;
    annotate Risks with @odata.draft.enabled;

    entity Mitigations @(restrict: [
        {
            grant: 'READ',
            to   : 'RiskViewer'
        },
        {
            grant: '*', // Allow everything using wildcard
            to   : 'RiskManager'
        }
    ]) as projection on rm.Mitigations;
    annotate Mitigations with @odata.draft.enabled;

    // BusinessPartner will be used later
    @readonly entity BusinessPartners as projection on rm.BusinessPartners;
}
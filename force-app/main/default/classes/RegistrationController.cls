public with sharing class RegistrationController {
    @AuraEnabled(cacheable=true)
    public static string getMeetup(String code, String email) {
        Meetup__c m = [SELECT id,registrationlimit__c,status__c FROM meetup__c WHERE RegistrationCode__c = :code LIMIT 1];

        List<MeetupRegistration__c> mrList = [SELECT id,email__c FROM MeetupRegistration__c WHERE meetup__c = :m.id]; 

        if (mrList.size() >= m.registrationlimit__c) {
            AuraHandledException e = new AuraHandledException('This meetup is full');
            e.setMessage('This meetup is full');
            throw e;
        }

        for (MeetupRegistration__c mr : mrList) {
            if (mr.email__c == email) {
                AuraHandledException e = new AuraHandledException('Email is already registered');
                e.setMessage('Email is already registered');
                throw e;
            }
        }

        if (m.status__c != 'Open') {
            AuraHandledException e = new AuraHandledException('This meetup registration is closed');
            e.setMessage('This meetup registration is closed');
            throw e;
        }

        return m.id;
    }
}


@isTest
public class RegistrationControllerTest {

    @isTest static void shouldRegBeAllowedOnClosedMeetup() {
        Meetup__c m = TestDataFactory.createMeetup('Test Meetup', 1, 'Closed');
        m = [select id,name,RegistrationCode__c from meetup__c where name = 'Test Meetup'];
        ID mid;
        Test.startTest();
            try {
                mID = RegistrationController.getMeetup(m.RegistrationCode__c,'test@test.com');
            }
            catch (AuraHandledException e) {
                System.assertEquals('This meetup registration is closed', e.getMessage());
            }
        Test.stopTest();
    }

    @isTest static void shouldRegBeAllowedOnFullMeetup() {
        Meetup__c m = TestDataFactory.createMeetup('Test Meetup', 2, 'Closed');
        MeetupRegistration__c mr = TestDataFactory.createReg(m.id, 'Last', 'First', 'test@test.com');
        MeetupRegistration__c mr1 = TestDataFactory.createReg(m.id, 'Last1', 'First1', 'test1@test.com');            
        m = [select id,name,RegistrationCode__c from meetup__c where name = 'Test Meetup'];
        ID mid;
        Test.startTest();
            try {
                mID = RegistrationController.getMeetup(m.RegistrationCode__c,'test2@test.com');
            }
            catch (AuraHandledException e) {
                System.assertEquals('This meetup is full', e.getMessage());
            }
        Test.stopTest();
    }

    @isTest static void shouldRegBeAllowedOnDuplicateEmail() {
        Meetup__c m = TestDataFactory.createMeetup('Test Meetup', 2, 'Closed');
        MeetupRegistration__c mr = TestDataFactory.createReg(m.id, 'Last', 'First', 'test@test.com');
        m = [select id,name,RegistrationCode__c from meetup__c where name = 'Test Meetup'];
        ID mid;
        Test.startTest();
            try {
                mID = RegistrationController.getMeetup(m.RegistrationCode__c,'test@test.com');
            }
            catch (AuraHandledException e) {
                System.assertEquals('Email is already registered', e.getMessage());
            }
        Test.stopTest();
    }

    @isTest static void shouldRegBeAllowedOnOpenMeetup() {
        Meetup__c m = TestDataFactory.createMeetup('Test Meetup', 1, 'Open');
        m = [select id,name,RegistrationCode__c from meetup__c where name = 'Test Meetup'];
        ID mid;
        Test.startTest();            
            try {
                mID = RegistrationController.getMeetup(m.RegistrationCode__c,'test@test.com');
            }
            catch (AuraHandledException e) {

            }
        Test.stopTest();
        System.assert(mID != null);
    }
}

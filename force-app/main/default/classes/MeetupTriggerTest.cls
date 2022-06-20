@isTest
public class MeetupTriggerTest {
    @isTest
    static void generateRegCodeOnMeetupCreate() {
        Test.startTest();
            Meetup__c m = TestDataFactory.createMeetup('Test Meetup', 1, 'Open'); // create a meetup
            m = [select id,name,RegistrationCode__c from meetup__c where name = 'Test Meetup']; // select meetup with registration code
        Test.stopTest();
        
        System.assert(m.RegistrationCode__c != null && m.RegistrationCode__c.length() == 8); // assert registration code was created with len 8
    }
}

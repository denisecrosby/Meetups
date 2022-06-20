@isTest
public class TestDataFactory {
    public static Meetup__c createMeetup(String MeetupName, Integer RegLimit, String status) {
        Meetup__c m = new Meetup__c();
        m.Name = MeetupName;
        m.RegistrationLimit__c = RegLimit;
        m.Status__c = status;

        insert m;
        return m;
    }

    public static MeetupRegistration__c createReg(ID MeetupID, String Lastname, String Firstname, String email) {
        MeetupRegistration__c mr = new MeetupRegistration__c();
        mr.Lastname__c = Lastname;
        mr.Firstname__c = Firstname;
        mr.Email__c = email;
        mr.meetup__c = MeetupID;

        insert mr;
        return mr;
    }    
}
trigger MeetupTrigger on Meetup__c (before insert) {
    MeetupTriggerHandler.SetRegistrationCode(Trigger.new);
}
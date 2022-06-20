public with sharing class MeetupTriggerHandler {
    public static void SetRegistrationCode(List<Meetup__c> meetups) {
        for (meetup__c m : meetups) {
            m.RegistrationCode__c = generateRandomString(8);
        }
    }

    private static String generateRandomString(Integer len) {
        //https://salesforce.stackexchange.com/questions/43823/how-do-i-generate-a-random-string
        final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';
        String randStr = '';
        while (randStr.length() < len) {
           Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
           randStr += chars.substring(idx, idx+1);
        }
        return randStr; 
    }

}

public with sharing class testClass {
    public testClass() {
        System.debug('hello');
    }

    public static void runThisClass(){


        String newString = 'hello String';

        List<Account> accList = [select id, name from account limit 5];

        for(Account acc: accList){
            System.debug(acc.Name);
            System.debug(acc.Id);
            
            acc.name = acc.name + newString;
        }
        
        system.debug(accList);

        update accList;
    }
}
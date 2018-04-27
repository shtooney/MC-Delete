// Not for implementation - not tested, not optimized, not bulkified, etc, etc, etc - this is purely for example sake
global class SendToMarketing {
    
    global class MyVars {
        @InvocableVariable(label='Subscriber ID' required=true)
        public String subscriberID;
	@InvocableVariable(label='First Name')
        public String firstName;  
        @InvocableVariable(label='Last Name')
        public String lastName;  
    }
    
    @InvocableMethod(label='Delete From Marketing Cloud')
    global static void invokeService(List<MyVars> vars){       
        for(MyVars var : vars){        
            MyMCdelete.myDelete(var.subscriberID, var.firstName, var.lastName);
        }
    }
}

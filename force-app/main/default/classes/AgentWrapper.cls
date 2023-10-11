public class AgentWrapper implements Comparable{
		Public string recId;
        Public string agentId;
     	Public string applicationType;
        Public string User;
        public integer remainingCapacity;
        public AgentWrapper(string agentId,string User,integer remainingCapacity,string recId,String applicationType){
            this.agentId = agentId;
            this.User = User;
            this.applicationType = applicationType;
            this.remainingCapacity = remainingCapacity;
            this.recId = recId;
        }
        public Integer compareTo(Object compareTo) {
            AgentWrapper otherWrapper = (AgentWrapper)compareTo;
            Integer returnValue = 0;
            if (this.remainingCapacity < otherWrapper.remainingCapacity) {
                returnValue = 1;
            } else if (this.remainingCapacity > otherWrapper.remainingCapacity) {
                returnValue = -1;
            } 
            return returnValue;
        }
}
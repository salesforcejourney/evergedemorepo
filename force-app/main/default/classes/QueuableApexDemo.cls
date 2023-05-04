//For all the account where rating is Hot, closed the opportunities as closed won;
public with sharing class QueuableApexDemo implements Queueable {
  //get all account where rating is hot along with the related opportunities
  //Account --> Parent
  //Opportuntinities --> child
  //Parent --> child
  //subquery with child relationship name
  public void execute(QueueableContext context) {
    updateOpportunityAsClosedWon();
  }

  public static void updateOpportunityAsClosedWon() {
    List<Opportunity> masterOppList = new List<Opportunity>();
    List<Account> accList = [
      SELECT
        id,
        name,
        (
          SELECT id, stagename
          FROM Opportunities
          WHERE stagename NOT IN ('Closed Won', 'Closed Lost')
        )
      FROM Account
      WHERE rating = 'Hot'
    ];
    for (Account acc : accList) {
      List<Opportunity> oppList = acc.Opportunities;
      for (Opportunity opp : oppList) {
        opp.stagename = 'Closed Won';
        masterOppList.add(opp);
      }
    }
    if (!masterOppList.isEmpty()) {
      try {
        update masterOppList;
      } catch (Exception ex) {
        System.debug('Error Message ' + ex.getMessage());
      }
    }
  }
}

/**
 *  
 Id jobId = System.enqueueJob(new QueuableApexDemo());
  System.debug('jobId' + jobId);
 */


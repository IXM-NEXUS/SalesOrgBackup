trigger QuoteLineItemTrigger on QuoteLineItem (after insert, after update, after delete, after undelete) {
    Set<Id> quoteIds = new Set<Id>();

    if (Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {
        for (QuoteLineItem qli : Trigger.new) {
            if (qli.QuoteId != null) {
                quoteIds.add(qli.QuoteId);
            }
        }
    }

    if (Trigger.isUpdate || Trigger.isDelete) {
        for (QuoteLineItem qli : Trigger.old) {
            if (qli.QuoteId != null) {
                quoteIds.add(qli.QuoteId);
            }
        }
    }

    if (!quoteIds.isEmpty()) {
        QuoteLineItemHelper.updateQuoteTotals(quoteIds);
    }
}
SELECT invid as "invoice ID", a AS "refund amount" FROM (SELECT invoices.invid, invoices.amount, sum(payments.amount), sum(payments.amount)-invoices.amount AS a FROM payments, invoices WHERE invoices.invid=payments.invid GROUP BY invoices.invid) AS foo WHERE a >0;
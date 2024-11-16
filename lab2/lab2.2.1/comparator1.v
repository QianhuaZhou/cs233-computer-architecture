module comparator1(pout, qout, a, b, pin, qin);
    output pout, qout;
    input  a, b, pin, qin;
    wire   not_p, not_q, not_a, not_b;
    wire   po2, po8, po9, po10, po11, po12, po13, po14, po15;
    wire   qo1, qo4, qo5, qo6, qo7, qo12, qo13, qo14, qo15;

    // input complements
    not np(not_p, pin);
    not nq(not_q, qin);
    not na(not_a, a);
    not nb(not_b, b);

    // po
    and p2(po2, not_p, not_q, a, not_b);
    and p8(po8, pin, not_q, not_a, not_b);
    and p9(po9, pin, not_q, not_a, b);
    and p10(po10, pin, not_q, a, not_b);
    and p11(po11, pin, not_q, a, b);
    and p12(po12, pin, qin, not_a, not_b);
    and p13(po13, pin, qin, not_a, b);
    and p14(po14, pin, qin, a, not_b);
    and p15(po15, pin, qin, a, b);
    or  op(pout, po2, po8, po9, po10, po11, po12, po13, po14, po15);

    // qo
    and q1(qo1, not_p, not_q, not_a, b);
    and q4(qo4, not_p, qin, not_a, not_b);
    and q5(qo5, not_p, qin, not_a, b);
    and q6(qo6, not_p, qin, a, not_b);
    and q7(qo7, not_p, qin, a, b);
    and q12(qo12, pin, qin, not_a, not_b);
    and q13(qo13, pin, qin, not_a, b);
    and q14(qo14, pin, qin, a, not_b);
    and q15(qo15, pin, qin, a, b);
    or  oq(qout, qo1, qo4, qo5, qo6, qo7, qo12, qo13, qo14, qo15);

endmodule // comparator

module comparator8(P, Q, A, B);
    output       P, Q;
    input[7:0]        A, B;

    // 7 bit buses to connect 1-bit modules
    wire   [6:0] p, q;  
        //comparator1(pout, qout, a, b, pin, qin);
    comparator1 c1(p[6], q[6], A[7], B[7], 1'b0, 1'b0);
    comparator1 c2(p[5], q[5], A[6], B[6], p[6], q[6]);
    comparator1 c3(p[4], q[4], A[5], B[5], p[5], q[5]);
    comparator1 c4(p[3], q[3], A[4], B[4], p[4], q[4]);
    comparator1 c5(p[2], q[2], A[3], B[3], p[3], q[3]);
    comparator1 c6(p[1], q[1], A[2], B[2], p[2], q[2]);
    comparator1 c7(p[0], q[0], A[1], B[1], p[1], q[1]);
    //comparator1 c8(P, Q, B[0], A[0], p[0], q[0]);
    comparator1 c8(P, Q,  A[0], B[0],p[0], q[0]);

endmodule // comparator8

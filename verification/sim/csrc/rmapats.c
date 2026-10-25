// file = 0; split type = patterns; threshold = 100000; total count = 0.
#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include "rmapats.h"

void  schedNewEvent (struct dummyq_struct * I1501, EBLK  * I1201, U  I624);
void  schedNewEvent (struct dummyq_struct * I1501, EBLK  * I1201, U  I624)
{
    U  I1807;
    U  I1808;
    U  I1809;
    struct futq * I1810;
    struct dummyq_struct * pQ = I1501;
    I1807 = ((U )vcs_clocks) + I624;
    I1809 = I1807 & ((1 << fHashTableSize) - 1);
    I1201->I670 = (EBLK  *)(-1);
    I1201->I671 = I1807;
    if (0 && rmaProfEvtProp) {
        vcs_simpSetEBlkEvtID((EBLK  *)I1201);
    }
    if (I1807 < (U )vcs_clocks) {
        I1808 = ((U  *)&vcs_clocks)[1];
        sched_millenium(pQ, I1201, I1808 + 1, I1807);
    }
    else if ((peblkFutQ1Head != ((void *)0)) && (I624 == 1)) {
        I1201->I673 = (struct eblk *)peblkFutQ1Tail;
        peblkFutQ1Tail->I670 = I1201;
        peblkFutQ1Tail = I1201;
    }
    else if ((I1810 = pQ->I1399[I1809].I696)) {
        I1201->I673 = (struct eblk *)I1810->I694;
        I1810->I694->I670 = (RP )I1201;
        I1810->I694 = (RmaEblk  *)I1201;
    }
    else {
        sched_hsopt(pQ, I1201, I1807);
    }
}
#ifdef __cplusplus
extern "C" {
#endif
void SinitHsimPats(void);
#ifdef __cplusplus
}
#endif

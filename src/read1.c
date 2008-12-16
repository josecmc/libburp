/****************************************************************
 * Hamid Benhocine                                              *
 * Ce programme C  cherche tous les rapports                    *
 * dans le fichier burp ainsi que les blocks de chaque rapport. *
 * Ici les cles de recherche par defaut sont utilsees.          *
 *                                                              *
 ****************************************************************/
#include "burp_api.h"

#ifdef  Linux
  MAIN_( int argc, char **argv ) 
#else      /* ----- #ifdef Linux  ----- */
int main ( int argc, char **argv ) 
#endif     /* ----- #ifdef Linux  ----- */
{
    BURP_BLK *bs, *br;
    BURP_RPT *rs, *rr;
    int iun;
    int istat;

    bs = brp_newblk();
    br = brp_newblk(); 
    rs = brp_newrpt();
    rr = brp_newrpt();
    iun = 10;
    /* voir si qqchose en argument*/
    if (!(argc -1)) 
    {
        printf("Un fichier burp en argument, s.v.p\n");
        return 1;
    }
    /* niveu tolerance erreur de burp */
    istat = brp_SetOptChar ( "MSGLVL",  "FATAL" );
    /* ouverture fichier burp passe en argument*/
    istat = brp_open(iun,argv[1],"r");
    printf("enreg %d\n",istat);

    RPT_SetHANDLE(rs,0);
    while ( brp_findrpt( iun, rs ) >= 0 ) 
    {
        if (brp_getrpt(iun, RPT_HANDLE(rs), rr) >= 0) 
        {
            printf("stnid = %s\n",RPT_STNID(rr));
            BLK_SetBKNO( bs, 0 );
            while ( brp_findblk( bs, rr ) >= 0 ) 
            {
                if (brp_getblk( BLK_BKNO(bs), br, rr )>=0) 
                    printf("block btyp = %d\n",BLK_BTYP(br));
            }
        }
    }
   /* liberer les ressources */
   brp_freeblk(bs);  
   brp_freeblk(br);
   brp_freerpt(rs);  
   brp_freerpt(rr);
   /* fermer fichier burp */
   istat = brp_close(iun);
}
/****************************************************************************
 *                                                                          *
 *                                                                          *
 * # Makefile   ----> utilser gmake (Gnu Make) ----------------             *
 * SHELL    = /bin/sh                                                       *
 * COMPILER = r.compile -src                                                *
 * DIRLIB=/software/cmc/burplib_c-1.0                                       *
 *                                                                          *
 *                                                                          *
 * read1:read1.c                                                            *
 * $(COMPILER) read1.c -conly -o $@_$(ARCH) -includes $(DIRLIB)/include\    *
 * -opt=-Wl,-rpath,$(ARMNLIB)/lib/$(ARCH):$(DIRLIB)/lib -librmn rmnshared \ *
 * -libpath $(DIRLIB)/lib  -libpriv burp_c                                  *
 *                                                                          *
 *                                                                          *
 ****************************************************************************/

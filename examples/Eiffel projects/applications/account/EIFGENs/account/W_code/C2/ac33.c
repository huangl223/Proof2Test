/*
 * Code for class ACCOUNT
 */

#include "eif_eiffel.h"
#include "../E1/estructure.h"


#ifdef __cplusplus
extern "C" {
#endif

extern void F33_1054(EIF_REFERENCE);
extern EIF_TYPED_VALUE F33_1055(EIF_REFERENCE);
extern EIF_TYPED_VALUE F33_1056(EIF_REFERENCE);
extern EIF_TYPED_VALUE F33_1057(EIF_REFERENCE);
extern void F33_1058(EIF_REFERENCE, EIF_TYPED_VALUE);
extern void F33_1059(EIF_REFERENCE, EIF_TYPED_VALUE);
extern void F33_1060(EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE);
extern void F33_9470(EIF_REFERENCE, int);
extern void EIF_Minit33(void);

#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


#ifdef __cplusplus
extern "C" {
#endif

/* {ACCOUNT}.make */
void F33_1054 (EIF_REFERENCE Current)
{
	GTCX
	char *l_feature_name = "make";
	RTEX;
	EIF_INTEGER_32 ti4_1;
	RTCDT;
	RTSN;
	RTDA;
	RTLD;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	RTLU (SK_VOID, NULL);
	RTLU (SK_REF, &Current);
	
	RTEAA(l_feature_name, 32, Current, 0, 0, 1069);
	RTSA(dtype);
	RTSC;
	RTME(dtype, 0);
	RTGC;
	RTDBGEAA(32, Current, 1069);
	RTIV(Current, RTAL);
	RTHOOK(1);
	RTDBGAA(Current, dtype, 1055, 0x10000000, 1); /* balance */
	*(EIF_INTEGER_32 *)(Current + RTWA(1055, dtype)) = (EIF_INTEGER_32) ((EIF_INTEGER_32) 0L);
	RTHOOK(2);
	RTDBGAA(Current, dtype, 1056, 0x10000000, 1); /* credit_limit */
	*(EIF_INTEGER_32 *)(Current + RTWA(1056, dtype)) = (EIF_INTEGER_32) ((EIF_INTEGER_32) 0L);
	if (RTAL & CK_ENSURE) {
		RTHOOK(3);
		RTCT("balance_set", EX_POST);
		ti4_1 = *(EIF_INTEGER_32 *)(Current + RTWA(1055, dtype));
		if ((EIF_BOOLEAN)(ti4_1 == ((EIF_INTEGER_32) 0L))) {
			RTCK;
		} else {
			RTCF;
		}
		RTHOOK(4);
		RTCT("credit_limit_set", EX_POST);
		ti4_1 = *(EIF_INTEGER_32 *)(Current + RTWA(1056, dtype));
		if ((EIF_BOOLEAN)(ti4_1 == ((EIF_INTEGER_32) 0L))) {
			RTCK;
		} else {
			RTCF;
		}
	}
	RTVI(Current, RTAL);
	RTRS;
	RTHOOK(5);
	RTDBGLE;
	RTMD(0);
	RTLE;
	RTLO(2);
	RTEE;
}

/* {ACCOUNT}.balance */
EIF_TYPED_VALUE F33_1055 (EIF_REFERENCE Current)
{
	EIF_TYPED_VALUE r;
	r.type = SK_INT32;
	r.it_i4 = *(EIF_INTEGER_32 *)(Current + RTWA(1055,Dtype(Current)));
	return r;
}


/* {ACCOUNT}.credit_limit */
EIF_TYPED_VALUE F33_1056 (EIF_REFERENCE Current)
{
	EIF_TYPED_VALUE r;
	r.type = SK_INT32;
	r.it_i4 = *(EIF_INTEGER_32 *)(Current + RTWA(1056,Dtype(Current)));
	return r;
}


/* {ACCOUNT}.available_amount */
EIF_TYPED_VALUE F33_1057 (EIF_REFERENCE Current)
{
	GTCX
	char *l_feature_name = "available_amount";
	RTEX;
	EIF_TYPED_VALUE ur1x = {{0}, SK_REF};
#define ur1 ur1x.it_r
	EIF_TYPED_VALUE ur2x = {{0}, SK_REF};
#define ur2 ur2x.it_r
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE tr2 = NULL;
	EIF_INTEGER_32 ti4_1;
	EIF_INTEGER_32 ti4_2;
	EIF_BOOLEAN tb1;
	EIF_INTEGER_32 Result = ((EIF_INTEGER_32) 0);
	
	RTCFDT;
	RTCDT;
	RTSN;
	RTDA;
	RTLD;
	
	RTLI(5);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLR(2,tr2);
	RTLR(3,ur1);
	RTLR(4,ur2);
	RTLIU(5);
	RTLU (SK_INT32, &Result);
	RTLU (SK_REF, &Current);
	
	RTEAA(l_feature_name, 32, Current, 0, 0, 1072);
	RTSA(dtype);
	RTSC;
	RTME(dtype, 0);
	RTGC;
	RTDBGEAA(32, Current, 1072);
	RTIV(Current, RTAL);
	if ((RTAL & CK_REQUIRE) || RTAC) {
		RTHOOK(1);
		RTCT("reads_field ([\"credit_limit\", \"balance\"], Current)", EX_PRE);
		{
			static EIF_TYPE_INDEX typarr0[] = {0xFF01,0xFFF9,2,220,0xFF01,268,0xFF01,268,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(dftype, typarr0)));
			tr1 = RTLNTS(typres0.id, 3, 0);
		}
		tr2 = RTMS_EX_H("credit_limit",12,2049757044);
		((EIF_TYPED_VALUE *)tr1+1)->it_r = tr2;
		RTAR(tr1,tr2);
		tr2 = RTMS_EX_H("balance",7,1759143013);
		((EIF_TYPED_VALUE *)tr1+2)->it_r = tr2;
		RTAR(tr1,tr2);
		ur1 = tr1;
		{
			EIF_TYPE_INDEX typarr0[] = {0xFF01,0xFFF9,1,220,0xFF01,0,0xFFFF};
			EIF_TYPE typres0;
			typarr0[5] = dftype;
			
			typres0 = eif_compound_id(dftype, typarr0);
			tr2 = RTLNTS(typres0.id, 2, 0);
		}
		((EIF_TYPED_VALUE *)tr2+1)->it_r = Current;
		RTAR(tr2,Current);
		ur2 = RTCCL(tr2);
		tb1 = (((FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTWF(46, dtype))(Current, ur1x, ur2x)).it_b);
		RTTE(tb1, label_1);
		RTCK;
		RTJB;
label_1:
		RTCF;
	}
body:;
	RTHOOK(2);
	RTDBGAL(0, 0x10000000, 1,0); /* Result */
	ti4_1 = *(EIF_INTEGER_32 *)(Current + RTWA(1055, dtype));
	ti4_2 = *(EIF_INTEGER_32 *)(Current + RTWA(1056, dtype));
	Result = (EIF_INTEGER_32) (EIF_INTEGER_32) (ti4_1 - ti4_2);
	RTVI(Current, RTAL);
	RTRS;
	RTHOOK(3);
	RTDBGLE;
	RTMD(0);
	RTLE;
	RTLO(2);
	RTEE;
	{ EIF_TYPED_VALUE r; r.type = SK_INT32; r.it_i4 = Result; return r; }
#undef ur1
#undef ur2
}

/* {ACCOUNT}.deposit */
void F33_1058 (EIF_REFERENCE Current, EIF_TYPED_VALUE arg1x)
{
	GTCX
	char *l_feature_name = "deposit";
	RTEX;
#define arg1 arg1x.it_i4
	EIF_TYPED_VALUE ur1x = {{0}, SK_REF};
#define ur1 ur1x.it_r
	EIF_TYPED_VALUE ur2x = {{0}, SK_REF};
#define ur2 ur2x.it_r
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE tr2 = NULL;
	EIF_INTEGER_32 ti4_1;
	EIF_INTEGER_32 ti4_2;
	EIF_BOOLEAN tb1;
	RTCFDT;
	RTCDT;
	RTSN;
	RTDA;
	RTLD;
	
	if ((arg1x.type & SK_HEAD) == SK_REF) arg1x.it_i4 = * (EIF_INTEGER_32 *) arg1x.it_r;
	
	RTLI(5);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLR(2,tr2);
	RTLR(3,ur1);
	RTLR(4,ur2);
	RTLIU(5);
	RTLU (SK_VOID, NULL);
	RTLU(SK_INT32,&arg1);
	RTLU (SK_REF, &Current);
	
	RTEAA(l_feature_name, 32, Current, 0, 1, 1073);
	RTSA(dtype);
	RTSC;
	RTME(dtype, 0);
	RTGC;
	RTDBGEAA(32, Current, 1073);
	RTIV(Current, RTAL);
	if ((RTAL & CK_REQUIRE) || RTAC) {
		RTHOOK(1);
		RTCT("balance >= credit_limit", EX_PRE);
		ti4_1 = *(EIF_INTEGER_32 *)(Current + RTWA(1055, dtype));
		ti4_2 = *(EIF_INTEGER_32 *)(Current + RTWA(1056, dtype));
		RTTE((EIF_BOOLEAN) (ti4_1 >= ti4_2), label_1);
		RTCK;
		RTHOOK(2);
		RTCT("0 >= credit_limit", EX_PRE);
		ti4_1 = *(EIF_INTEGER_32 *)(Current + RTWA(1056, dtype));
		RTTE((EIF_BOOLEAN) (((EIF_INTEGER_32) 0L) >= ti4_1), label_1);
		RTCK;
		RTJB;
label_1:
		RTCF;
	}
body:;
	if (RTAL & CK_ENSURE) {
		in_assertion = ~0;
		ti4_2 = *(EIF_INTEGER_32 *)(Current + RTWA(1055, dtype));
		ti4_1 = ti4_2;
		in_assertion = 0;
	}
	RTHOOK(3);
	RTDBGAA(Current, dtype, 1055, 0x10000000, 1); /* balance */
	(*(EIF_INTEGER_32 *)(Current + RTWA(1055, dtype))) += arg1;
	if (RTAL & CK_ENSURE) {
		RTHOOK(4);
		RTCT("modify_field ([\"balance\"], Current)", EX_POST);
		{
			static EIF_TYPE_INDEX typarr0[] = {0xFF01,0xFFF9,1,220,0xFF01,268,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(dftype, typarr0)));
			tr1 = RTLNTS(typres0.id, 2, 0);
		}
		tr2 = RTMS_EX_H("balance",7,1759143013);
		((EIF_TYPED_VALUE *)tr1+1)->it_r = tr2;
		RTAR(tr1,tr2);
		ur1 = tr1;
		{
			EIF_TYPE_INDEX typarr0[] = {0xFF01,0xFFF9,1,220,0xFF01,0,0xFFFF};
			EIF_TYPE typres0;
			typarr0[5] = dftype;
			
			typres0 = eif_compound_id(dftype, typarr0);
			tr2 = RTLNTS(typres0.id, 2, 0);
		}
		((EIF_TYPED_VALUE *)tr2+1)->it_r = Current;
		RTAR(tr2,Current);
		ur2 = RTCCL(tr2);
		tb1 = (((FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTWF(42, dtype))(Current, ur1x, ur2x)).it_b);
		if (tb1) {
			RTCK;
		} else {
			RTCF;
		}
		RTHOOK(5);
		RTCT("balance_increased", EX_POST);
		ti4_2 = *(EIF_INTEGER_32 *)(Current + RTWA(1055, dtype));
		if ((EIF_BOOLEAN) (ti4_2 >= ti4_1)) {
			RTCK;
		} else {
			RTCF;
		}
	}
	RTVI(Current, RTAL);
	RTRS;
	RTHOOK(6);
	RTDBGLE;
	RTMD(0);
	RTLE;
	RTLO(3);
	RTEE;
#undef ur1
#undef ur2
#undef arg1
}

/* {ACCOUNT}.withdraw */
void F33_1059 (EIF_REFERENCE Current, EIF_TYPED_VALUE arg1x)
{
	GTCX
	char *l_feature_name = "withdraw";
	RTEX;
#define arg1 arg1x.it_i4
	EIF_TYPED_VALUE ur1x = {{0}, SK_REF};
#define ur1 ur1x.it_r
	EIF_TYPED_VALUE ur2x = {{0}, SK_REF};
#define ur2 ur2x.it_r
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE tr2 = NULL;
	EIF_INTEGER_32 ti4_1;
	EIF_INTEGER_32 ti4_2;
	EIF_INTEGER_32 ti4_3;
	EIF_BOOLEAN tb1;
	RTCFDT;
	RTCDT;
	RTSN;
	RTDA;
	RTLD;
	
	if ((arg1x.type & SK_HEAD) == SK_REF) arg1x.it_i4 = * (EIF_INTEGER_32 *) arg1x.it_r;
	
	RTLI(5);
	RTLR(0,Current);
	RTLR(1,tr1);
	RTLR(2,tr2);
	RTLR(3,ur1);
	RTLR(4,ur2);
	RTLIU(5);
	RTLU (SK_VOID, NULL);
	RTLU(SK_INT32,&arg1);
	RTLU (SK_REF, &Current);
	
	RTEAA(l_feature_name, 32, Current, 0, 1, 1074);
	RTSA(dtype);
	RTSC;
	RTME(dtype, 0);
	RTGC;
	RTDBGEAA(32, Current, 1074);
	RTIV(Current, RTAL);
	if ((RTAL & CK_REQUIRE) || RTAC) {
		RTHOOK(1);
		RTCT("amount_not_negative", EX_PRE);
		RTTE((EIF_BOOLEAN) (arg1 >= ((EIF_INTEGER_32) 0L)), label_1);
		RTCK;
		RTHOOK(2);
		RTCT("balance >= credit_limit", EX_PRE);
		ti4_1 = *(EIF_INTEGER_32 *)(Current + RTWA(1055, dtype));
		ti4_2 = *(EIF_INTEGER_32 *)(Current + RTWA(1056, dtype));
		RTTE((EIF_BOOLEAN) (ti4_1 >= ti4_2), label_1);
		RTCK;
		RTHOOK(3);
		RTCT("0 >= credit_limit", EX_PRE);
		ti4_1 = *(EIF_INTEGER_32 *)(Current + RTWA(1056, dtype));
		RTTE((EIF_BOOLEAN) (((EIF_INTEGER_32) 0L) >= ti4_1), label_1);
		RTCK;
		RTHOOK(4);
		RTCT("amount <= available_amount", EX_PRE);
		ti4_1 = (((FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE)) RTWF(1057, dtype))(Current)).it_i4);
		RTTE((EIF_BOOLEAN) (arg1 <= ti4_1), label_1);
		RTCK;
		RTJB;
label_1:
		RTCF;
	}
body:;
	if (RTAL & CK_ENSURE) {
		in_assertion = ~0;
		ti4_2 = *(EIF_INTEGER_32 *)(Current + RTWA(1055, dtype));
		ti4_1 = ti4_2;
		in_assertion = 0;
	}
	RTHOOK(5);
	RTDBGAA(Current, dtype, 1055, 0x10000000, 1); /* balance */
	(*(EIF_INTEGER_32 *)(Current + RTWA(1055, dtype))) += arg1;
	if (RTAL & CK_ENSURE) {
		RTHOOK(6);
		RTCT("modify_field ([\"balance\"], Current)", EX_POST);
		{
			static EIF_TYPE_INDEX typarr0[] = {0xFF01,0xFFF9,1,220,0xFF01,268,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(dftype, typarr0)));
			tr1 = RTLNTS(typres0.id, 2, 0);
		}
		tr2 = RTMS_EX_H("balance",7,1759143013);
		((EIF_TYPED_VALUE *)tr1+1)->it_r = tr2;
		RTAR(tr1,tr2);
		ur1 = tr1;
		{
			EIF_TYPE_INDEX typarr0[] = {0xFF01,0xFFF9,1,220,0xFF01,0,0xFFFF};
			EIF_TYPE typres0;
			typarr0[5] = dftype;
			
			typres0 = eif_compound_id(dftype, typarr0);
			tr2 = RTLNTS(typres0.id, 2, 0);
		}
		((EIF_TYPED_VALUE *)tr2+1)->it_r = Current;
		RTAR(tr2,Current);
		ur2 = RTCCL(tr2);
		tb1 = (((FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTWF(42, dtype))(Current, ur1x, ur2x)).it_b);
		if (tb1) {
			RTCK;
		} else {
			RTCF;
		}
		RTHOOK(7);
		RTCT("balance_set", EX_POST);
		ti4_2 = *(EIF_INTEGER_32 *)(Current + RTWA(1055, dtype));
		if ((EIF_BOOLEAN)(ti4_2 == (EIF_INTEGER_32) (ti4_1 - arg1))) {
			RTCK;
		} else {
			RTCF;
		}
		RTHOOK(8);
		RTCT("balance >= credit_limit", EX_POST);
		ti4_2 = *(EIF_INTEGER_32 *)(Current + RTWA(1055, dtype));
		ti4_3 = *(EIF_INTEGER_32 *)(Current + RTWA(1056, dtype));
		if ((EIF_BOOLEAN) (ti4_2 >= ti4_3)) {
			RTCK;
		} else {
			RTCF;
		}
		RTHOOK(9);
		RTCT("0 >= credit_limit", EX_POST);
		ti4_2 = *(EIF_INTEGER_32 *)(Current + RTWA(1056, dtype));
		if ((EIF_BOOLEAN) (((EIF_INTEGER_32) 0L) >= ti4_2)) {
			RTCK;
		} else {
			RTCF;
		}
	}
	RTVI(Current, RTAL);
	RTRS;
	RTHOOK(10);
	RTDBGLE;
	RTMD(0);
	RTLE;
	RTLO(3);
	RTEE;
#undef ur1
#undef ur2
#undef arg1
}

/* {ACCOUNT}.transfer */
void F33_1060 (EIF_REFERENCE Current, EIF_TYPED_VALUE arg1x, EIF_TYPED_VALUE arg2x)
{
	GTCX
	char *l_feature_name = "transfer";
	RTEX;
#define arg1 arg1x.it_i4
#define arg2 arg2x.it_r
	EIF_TYPED_VALUE ur1x = {{0}, SK_REF};
#define ur1 ur1x.it_r
	EIF_TYPED_VALUE ur2x = {{0}, SK_REF};
#define ur2 ur2x.it_r
	EIF_TYPED_VALUE ui4_1x = {{0}, SK_INT32};
#define ui4_1 ui4_1x.it_i4
	EIF_REFERENCE tr1 = NULL;
	EIF_REFERENCE tr2 = NULL;
	EIF_REFERENCE tr3 = NULL;
	EIF_INTEGER_32 ti4_1;
	EIF_INTEGER_32 ti4_2;
	EIF_INTEGER_32 ti4_3;
	EIF_BOOLEAN tb1;
	RTCFDT;
	RTCDT;
	RTSN;
	RTDA;
	RTLD;
	
	if ((arg1x.type & SK_HEAD) == SK_REF) arg1x.it_i4 = * (EIF_INTEGER_32 *) arg1x.it_r;
	
	RTLI(7);
	RTLR(0,arg2);
	RTLR(1,Current);
	RTLR(2,tr1);
	RTLR(3,tr2);
	RTLR(4,tr3);
	RTLR(5,ur1);
	RTLR(6,ur2);
	RTLIU(7);
	RTLU (SK_VOID, NULL);
	RTLU(SK_INT32,&arg1);
	RTLU(SK_REF,&arg2);
	RTLU (SK_REF, &Current);
	
	RTEAA(l_feature_name, 32, Current, 0, 2, 1075);
	RTSA(dtype);
	RTSC;
	RTME(dtype, 0);
	RTGC;
	RTDBGEAA(32, Current, 1075);
	RTCC(arg2, 32, l_feature_name, 2, eif_new_type(32, 0x01), 0x01);
	RTIV(Current, RTAL);
	if ((RTAL & CK_REQUIRE) || RTAC) {
		RTHOOK(1);
		RTCT("other /= Void", EX_PRE);
		RTTE((EIF_BOOLEAN)(arg2 != NULL), label_1);
		RTCK;
		RTHOOK(2);
		RTCT("amount_not_negative", EX_PRE);
		tb1 = '\0';
		ti4_1 = *(EIF_INTEGER_32 *)(Current + RTWA(1056, dtype));
		if ((EIF_BOOLEAN) ((EIF_BOOLEAN) (arg1 > ((EIF_INTEGER_32) 0L)) && (EIF_BOOLEAN) (((EIF_INTEGER_32) 0L) >= ti4_1))) {
			ti4_1 = *(EIF_INTEGER_32 *)(arg2 + RTVA(1056, "credit_limit", arg2));
			tb1 = (EIF_BOOLEAN) (((EIF_INTEGER_32) 0L) >= ti4_1);
		}
		RTTE(tb1, label_1);
		RTCK;
		RTHOOK(3);
		RTCT("amount_available", EX_PRE);
		ti4_1 = (((FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE)) RTWF(1057, dtype))(Current)).it_i4);
		RTTE((EIF_BOOLEAN) (arg1 <= ti4_1), label_1);
		RTCK;
		RTHOOK(4);
		RTCT("balance_non_negative", EX_PRE);
		tb1 = '\0';
		ti4_1 = *(EIF_INTEGER_32 *)(Current + RTWA(1055, dtype));
		ti4_2 = *(EIF_INTEGER_32 *)(Current + RTWA(1056, dtype));
		if ((EIF_BOOLEAN) (ti4_1 >= ti4_2)) {
			ti4_1 = *(EIF_INTEGER_32 *)(arg2 + RTVA(1055, "balance", arg2));
			ti4_2 = *(EIF_INTEGER_32 *)(arg2 + RTVA(1056, "credit_limit", arg2));
			tb1 = (EIF_BOOLEAN) (ti4_1 >= ti4_2);
		}
		RTTE(tb1, label_1);
		RTCK;
		RTHOOK(5);
		RTCT("balance <= 10", EX_PRE);
		ti4_1 = *(EIF_INTEGER_32 *)(Current + RTWA(1055, dtype));
		RTTE((EIF_BOOLEAN) (ti4_1 <= ((EIF_INTEGER_32) 10L)), label_1);
		RTCK;
		RTHOOK(6);
		RTCT("credit_limit <= 20", EX_PRE);
		ti4_1 = *(EIF_INTEGER_32 *)(Current + RTWA(1056, dtype));
		RTTE((EIF_BOOLEAN) (ti4_1 <= ((EIF_INTEGER_32) 20L)), label_1);
		RTCK;
		RTJB;
label_1:
		RTCF;
	}
body:;
	if (RTAL & CK_ENSURE) {
		in_assertion = ~0;
		ti4_2 = *(EIF_INTEGER_32 *)(Current + RTWA(1055, dtype));
		ti4_1 = ti4_2;
		RTE_OT
		ti4_3 = *(EIF_INTEGER_32 *)(arg2 + RTVA(1055, "balance", arg2));
		ti4_2 = ti4_3;
		tr1 = NULL;
		RTE_O
		tr1 = RTLA;
		RTE_OE
		in_assertion = 0;
	}
	RTHOOK(7);
	ui4_1 = arg1;
	(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_TYPED_VALUE)) RTWF(1059, dtype))(Current, ui4_1x);
	RTHOOK(8);
	ui4_1 = arg1;
	(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_TYPED_VALUE)) RTVF(1058, "deposit", arg2))(arg2, ui4_1x);
	if (RTAL & CK_ENSURE) {
		RTHOOK(9);
		RTCT("modify_field ([\"balance\", \"closed\"], [Current, other])", EX_POST);
		{
			static EIF_TYPE_INDEX typarr0[] = {0xFF01,0xFFF9,2,220,0xFF01,268,0xFF01,268,0xFFFF};
			EIF_TYPE typres0;
			static EIF_TYPE typcache0 = {INVALID_DTYPE, 0};
			
			typres0 = (typcache0.id != INVALID_DTYPE ? typcache0 : (typcache0 = eif_compound_id(dftype, typarr0)));
			tr2 = RTLNTS(typres0.id, 3, 0);
		}
		tr3 = RTMS_EX_H("balance",7,1759143013);
		((EIF_TYPED_VALUE *)tr2+1)->it_r = tr3;
		RTAR(tr2,tr3);
		tr3 = RTMS_EX_H("closed",6,2065304932);
		((EIF_TYPED_VALUE *)tr2+2)->it_r = tr3;
		RTAR(tr2,tr3);
		ur1 = tr2;
		{
			EIF_TYPE_INDEX typarr0[] = {0xFF01,0xFFF9,2,220,0xFF01,0,0xFF01,32,0xFFFF};
			EIF_TYPE typres0;
			typarr0[5] = dftype;
			
			typres0 = eif_compound_id(dftype, typarr0);
			tr3 = RTLNTS(typres0.id, 3, 0);
		}
		((EIF_TYPED_VALUE *)tr3+1)->it_r = Current;
		RTAR(tr3,Current);
		((EIF_TYPED_VALUE *)tr3+2)->it_r = arg2;
		RTAR(tr3,arg2);
		ur2 = RTCCL(tr3);
		tb1 = (((FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTWF(42, dtype))(Current, ur1x, ur2x)).it_b);
		if (tb1) {
			RTCK;
		} else {
			RTCF;
		}
		RTHOOK(10);
		RTCT("withdrawal_made", EX_POST);
		ti4_3 = *(EIF_INTEGER_32 *)(Current + RTWA(1055, dtype));
		if ((EIF_BOOLEAN)(ti4_3 == (EIF_INTEGER_32) (ti4_1 - arg1))) {
			RTCK;
		} else {
			RTCF;
		}
		RTHOOK(11);
		RTCT("deposit_made", EX_POST);
		ti4_3 = *(EIF_INTEGER_32 *)(arg2 + RTVA(1055, "balance", arg2));
		RTCO(tr1);
		if ((EIF_BOOLEAN)(ti4_3 == (EIF_INTEGER_32) (ti4_2 + arg1))) {
			RTCK;
		} else {
			RTCF;
		}
	}
	RTVI(Current, RTAL);
	RTRS;
	RTHOOK(12);
	RTDBGLE;
	RTMD(0);
	RTLE;
	RTLO(4);
	RTEE;
#undef ur1
#undef ur2
#undef ui4_1
#undef arg2
#undef arg1
}

/* {ACCOUNT}._invariant */
void F33_9470 (EIF_REFERENCE Current, int where)
{
	GTCX
	char *l_feature_name = "_invariant";
	RTEX;
	EIF_INTEGER_32 ti4_1;
	RTCDT;
	RTLD;
	RTDA;
	
	RTLI(1);
	RTLR(0,Current);
	RTLIU(1);
	RTLU (SK_VOID, NULL);
	RTLU (SK_REF, &Current);
	RTEAINV(l_feature_name, 32, Current, 0, 9469);
	RTSA(dtype);
	RTME(dtype, 0);
	RTIT("credit_limit_not_positive", Current);
	ti4_1 = (((FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE)) RTWF(1057, dtype))(Current)).it_i4);
	if ((EIF_BOOLEAN) (((EIF_INTEGER_32) 0L) >= ti4_1)) {
		RTCK;
	} else {
		RTCF;
	}
	RTLO(2);
	RTMD(0);
	RTLE;
	RTEE;
}

void EIF_Minit33 (void)
{
	GTCX
}


#ifdef __cplusplus
}
#endif

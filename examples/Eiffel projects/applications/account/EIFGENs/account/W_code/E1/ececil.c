#include "eif_eiffel.h"
#include "eif_rout_obj.h"
#include "eaddress.h"

#ifdef __cplusplus
extern "C" {
#endif

	/* EQA_SYSTEM_PATH extend */
void _A7_89_2 ( void(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_TYPED_VALUE)) RTVF(467, "extend", closed [1].it_r))(closed [1].it_r, open [1]);
}

	/* EQA_TEST_EVALUATOR [G#1] inline-agent#1 of execute */
EIF_TYPED_VALUE _A1827_317 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE)) F1827_9496)(closed [1].it_r);
}

	/* PROCEDURE [G#1] call */
void _A324_186 ( void(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_TYPED_VALUE)) RTVF(6004, "call", closed [1].it_r))(closed [1].it_r, closed [2]);
}

	/* EQA_TEST_SET clean */
void _A53_85 ( void(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_TYPED_VALUE)) RTVF(1431, "clean", closed [1].it_r))(closed [1].it_r, closed [2]);
}

	/* EQA_EVALUATOR invoke_routine */
void _A179_254_2 ( void(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(2139, "invoke_routine", closed [1].it_r))(closed [1].it_r, open [1], closed [2]);
}

	/* RT_DBG_CALL_RECORD inline-agent#1 of record_fields */
void _A182_205_2 ( void(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_TYPED_VALUE)) F182_9497)(closed [1].it_r, open [1]);
}

	/* MML_MAP [INTEGER_32, TYPED_POINTER [ANY]] meq_value */
EIF_TYPED_VALUE _A335_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MML_MAP [INTEGER_32, INTEGER_32] meq_value */
EIF_TYPED_VALUE _A360_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MML_MAP [INTEGER_32, G#2] meq_value */
EIF_TYPED_VALUE _A411_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MML_MAP [INTEGER_32, POINTER] meq_value */
EIF_TYPED_VALUE _A457_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MML_MAP [INTEGER_32, REAL_64] meq_value */
EIF_TYPED_VALUE _A503_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MML_MAP [INTEGER_32, REAL_32] meq_value */
EIF_TYPED_VALUE _A549_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MML_MAP [INTEGER_32, NATURAL_8] meq_value */
EIF_TYPED_VALUE _A595_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MML_MAP [INTEGER_32, NATURAL_16] meq_value */
EIF_TYPED_VALUE _A641_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MML_MAP [INTEGER_32, NATURAL_32] meq_value */
EIF_TYPED_VALUE _A687_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MML_MAP [INTEGER_32, NATURAL_64] meq_value */
EIF_TYPED_VALUE _A733_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MML_MAP [INTEGER_32, INTEGER_8] meq_value */
EIF_TYPED_VALUE _A779_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MML_MAP [INTEGER_32, INTEGER_16] meq_value */
EIF_TYPED_VALUE _A825_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MML_MAP [INTEGER_32, INTEGER_64] meq_value */
EIF_TYPED_VALUE _A871_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MML_MAP [INTEGER_32, CHARACTER_8] meq_value */
EIF_TYPED_VALUE _A917_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MML_MAP [INTEGER_32, CHARACTER_32] meq_value */
EIF_TYPED_VALUE _A963_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MML_MAP [INTEGER_32, BOOLEAN] meq_value */
EIF_TYPED_VALUE _A1009_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MML_MAP [INTEGER_32, TYPED_POINTER [INTEGER_32]] meq_value */
EIF_TYPED_VALUE _A1057_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MML_MAP [INTEGER_32, UTF_CONVERTER] meq_value */
EIF_TYPED_VALUE _A1107_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MML_MAP [INTEGER_32, TYPED_POINTER [NATURAL_64]] meq_value */
EIF_TYPED_VALUE _A1170_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MML_MAP [INTEGER_32, TYPED_POINTER [BOOLEAN]] meq_value */
EIF_TYPED_VALUE _A1219_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MML_MAP [INTEGER_32, TYPED_POINTER [INTEGER_8]] meq_value */
EIF_TYPED_VALUE _A1268_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MML_MAP [INTEGER_32, TYPED_POINTER [INTEGER_16]] meq_value */
EIF_TYPED_VALUE _A1317_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MML_MAP [INTEGER_32, TYPED_POINTER [INTEGER_64]] meq_value */
EIF_TYPED_VALUE _A1367_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MML_MAP [INTEGER_32, TYPED_POINTER [NATURAL_8]] meq_value */
EIF_TYPED_VALUE _A1416_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MML_MAP [INTEGER_32, TYPED_POINTER [NATURAL_16]] meq_value */
EIF_TYPED_VALUE _A1465_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MML_MAP [INTEGER_32, TYPED_POINTER [NATURAL_32]] meq_value */
EIF_TYPED_VALUE _A1514_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MML_MAP [INTEGER_32, TYPED_POINTER [REAL_64]] meq_value */
EIF_TYPED_VALUE _A1564_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MML_MAP [INTEGER_32, TYPED_POINTER [REAL_32]] meq_value */
EIF_TYPED_VALUE _A1613_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MML_MAP [INTEGER_32, TYPED_POINTER [CHARACTER_8]] meq_value */
EIF_TYPED_VALUE _A1662_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MML_MAP [INTEGER_32, TYPED_POINTER [CHARACTER_32]] meq_value */
EIF_TYPED_VALUE _A1711_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MML_MAP [INTEGER_32, TYPED_POINTER [POINTER]] meq_value */
EIF_TYPED_VALUE _A1761_102_3 ( EIF_TYPED_VALUE(*f_ptr) (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE), EIF_TYPED_VALUE * closed, EIF_TYPED_VALUE * open)
{
	GTCX
	return (FUNCTION_CAST(EIF_TYPED_VALUE, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(3817, "meq_value", closed [1].it_r))(closed [1].it_r, closed [2], open [1]);
}

	/* MISMATCH_INFORMATION wipe_out */
void A216_144 (EIF_REFERENCE Current)
{
	GTCX
	(FUNCTION_CAST(void, (EIF_REFERENCE)) RTVF(4201, "wipe_out", Current))(Current);
}

	/* MISMATCH_INFORMATION internal_put */
void A216_208 (EIF_REFERENCE Current, EIF_REFERENCE arg1, EIF_POINTER arg2)
{
	EIF_TYPED_VALUE u [2];
	GTCX
	(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(4934, "internal_put", Current))(Current, ((u [0].type = SK_REF), (u [0].it_r = arg1), u [0]), ((u [1].type = SK_POINTER), (u [1].it_p = arg2), u [1]));
}

	/* MISMATCH_INFORMATION set_string_versions */
void A216_209 (EIF_REFERENCE Current, EIF_POINTER arg1, EIF_POINTER arg2)
{
	EIF_TYPED_VALUE u [2];
	GTCX
	(FUNCTION_CAST(void, (EIF_REFERENCE, EIF_TYPED_VALUE, EIF_TYPED_VALUE)) RTVF(4935, "set_string_versions", Current))(Current, ((u [0].type = SK_POINTER), (u [0].it_p = arg1), u [0]), ((u [1].type = SK_POINTER), (u [1].it_p = arg2), u [1]));
}


static fnptr feif_address_table[] = {
(fnptr)0,
(fnptr)A216_144,
(fnptr)A216_208,
(fnptr)A216_209,
};

fnptr *egc_address_table_init = feif_address_table;



#ifdef __cplusplus
}
#endif

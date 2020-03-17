#include <stddef.h>
#include <stdint.h>

//#define field ## _SIZE 0x1000 \

/* const */
/* const */
/* const */

#define MEMORY_FIELD(field, field_size) \
size_t field ##_size = field_size; \
uint8_t mem_## field ## [field_size]; \
uint8_t* field = mem_ ## field; \
uint8_t* field ## _end = (uint8_t*) &mem_ ## field[field_size];

#define AUTHORS_SIZE 0x1000
// const size_t AUTHORS_gz_size = AUTHORS_SIZE;
size_t AUTHORS_gz_size = AUTHORS_SIZE;
uint8_t mem_AUTHORS[AUTHORS_SIZE];
uint8_t* AUTHORS_gz = mem_AUTHORS;  // new uint8_t[AUTHORS_gz_size];
uint8_t* AUTHORS_gz_end = (uint8_t const*) &mem_AUTHORS[AUTHORS_SIZE];

// MEMORY_FIELD(AUTHORS_gz, 0x1000)
MEMORY_FIELD(COPYING_gz, 0x1000)
MEMORY_FIELD(ca_mo, 0x1000)MEMORY_FIELD(cs_mo, 0x1000)MEMORY_FIELD(da_mo, 0x1000)MEMORY_FIELD(de_mo, 0x1000)MEMORY_FIELD(egm96s_dem, 0x1000)MEMORY_FIELD(el_mo, 0x1000)MEMORY_FIELD(es_mo, 0x1000)MEMORY_FIELD(fi_mo, 0x1000)MEMORY_FIELD(fr_mo, 0x1000)
MEMORY_FIELD(he_mo, 0x1000)
MEMORY_FIELD(hr_mo, 0x1000)
MEMORY_FIELD(hu_mo, 0x1000)
MEMORY_FIELD(it_mo, 0x1000)
MEMORY_FIELD(ja_mo, 0x1000)
MEMORY_FIELD(ko_mo, 0x1000)
MEMORY_FIELD(lt_mo, 0x1000)
MEMORY_FIELD(nb_mo, 0x1000)
MEMORY_FIELD(nl_mo, 0x1000)
MEMORY_FIELD(pl_mo, 0x1000)
MEMORY_FIELD(pt_mo, 0x1000)
MEMORY_FIELD(pt_BR_mo, 0x1000)
MEMORY_FIELD(ro_mo, 0x1000)
MEMORY_FIELD(ru_mo, 0x1000)
MEMORY_FIELD(sk_mo, 0x1000)
MEMORY_FIELD(sl_mo, 0x1000)
MEMORY_FIELD(sr_mo, 0x1000)
MEMORY_FIELD(sv_mo, 0x1000)
MEMORY_FIELD(tr_mo, 0x1000)
MEMORY_FIELD(uk_mo, 0x1000)
MEMORY_FIELD(vi_mo, 0x1000)
MEMORY_FIELD(zh_CN_mo, 0x1000)
MEMORY_FIELD(zh_Hant_mo, 0x1000)

#if 0
extern const uint8_t cs_mo[];
extern const uint8_t da_mo[];
extern const uint8_t de_mo[];
extern const uint8_t el_mo[];
extern const uint8_t es_mo[];
extern const uint8_t fi_mo[];
extern const uint8_t fr_mo[];
extern const uint8_t he_mo[];
extern const uint8_t hr_mo[];
extern const uint8_t hu_mo[];
extern const uint8_t it_mo[];
extern const uint8_t ja_mo[];
extern const uint8_t ko_mo[];
extern const uint8_t lt_mo[];
extern const uint8_t nb_mo[];
extern const uint8_t nl_mo[];
extern const uint8_t pl_mo[];
extern const uint8_t pt_BR_mo[];
extern const uint8_t pt_mo[];
extern const uint8_t ro_mo[];
extern const uint8_t ru_mo[];
extern const uint8_t sk_mo[];
extern const uint8_t sl_mo[];
extern const uint8_t sr_mo[];
extern const uint8_t sv_mo[];
extern const uint8_t tr_mo[];
extern const uint8_t uk_mo[];
extern const uint8_t vi_mo[];
extern const uint8_t zh_CN_mo[];
extern const uint8_t zh_Hant_mo[];
#endif

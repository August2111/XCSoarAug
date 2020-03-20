#ifndef JPC_RTC_H
#define JPC_RTC_H

#include "Util/Compiler.h"
#include "jasper/jas_seq.h"

struct jas_matrix;

#ifdef __cplusplus
extern "C" {
#endif

  gcc_const
  long jas_rtc_SkipMarkerSegment(void *loader, long file_offset);
  void jas_rtc_MarkerSegment(void *loader, long file_offset, unsigned id);
  void jas_rtc_ProcessComment(void *loader, const char *data, unsigned size);
  void jas_rtc_StartTile(void *loader, unsigned index);

  void jas_rtc_PutTileData(void* loader,
    unsigned index,
    unsigned start_x, unsigned start_y,
    unsigned end_x, unsigned end_y,
#ifdef JAS_2_0_0
    const struct jas_matrix* data);
#else
    const jas_matrix_t* data);
#endif

  void jas_rtc_SetSize(void *loader,
		       unsigned width, unsigned height,
		       unsigned tile_width, unsigned tile_height,
		       unsigned tile_columns, unsigned tile_rows);

#ifdef __cplusplus
}
#endif

#endif

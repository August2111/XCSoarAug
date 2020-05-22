/*
Copyright_License {

  XCSoar Glide Computer - http://www.xcsoar.org/
  Copyright (C) 2000-2016 The XCSoar Project
  A detailed list of copyright holders can be found in the file "AUTHORS".

  This program is free software; you can redistribute it and/or
  modify it under the terms of the GNU General Public License
  as published by the Free Software Foundation; either version 2
  of the License, or (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
}
*/

#include "Look/AirspaceLook.hpp"
#include "Screen/Layout.hpp"
#include "Renderer/AirspaceRendererSettings.hpp"
#include "Resources.hpp"
#include "Util/Macros.hpp"

const RGB8Color AirspaceLook::preset_colors[] = {
  RGB8_RED,
  RGB8_GREEN,
  RGB8_BLUE,
  RGB8_YELLOW,
  RGB8_MAGENTA,
  RGB8_CYAN,
  RGB8_RED.Darken(),
  RGB8_GREEN.Darken(),
  RGB8_BLUE.Darken(),
  RGB8_YELLOW.Darken(),
  RGB8_MAGENTA.Darken(),
  RGB8_CYAN.Darken(),
  RGB8_WHITE,
  RGB8_LIGHT_GRAY,
  RGB8_GRAY,
  RGB8_BLACK,
};

void
AirspaceClassLook::Initialise(const AirspaceClassRendererSettings &settings)
{
  fill_color = Color(settings.fill_color);

#if defined(HAVE_ALPHA_BLEND) || !defined(HAVE_HATCHED_BRUSH)
  solid_brush.Create(fill_color);
#endif

  if (settings.border_width != 0)
    border_pen.Create(Layout::ScalePenWidth(settings.border_width),
                      Color(settings.border_color));
}

#include <vector>
#include <cstring>
std::vector<unsigned char> ToPixels(HBITMAP BitmapHandle, int& width, int& height) {
    BITMAP Bmp = { 0 };
    BITMAPINFO Info = { 0 };
    std::vector<unsigned char> Pixels = std::vector<unsigned char>();

    HDC DC = CreateCompatibleDC(NULL);
    std::memset(&Info, 0, sizeof(BITMAPINFO)); //not necessary really..
    HBITMAP OldBitmap = (HBITMAP)SelectObject(DC, BitmapHandle);
    GetObject(BitmapHandle, sizeof(Bmp), &Bmp);

    Info.bmiHeader.biSize = sizeof(BITMAPINFOHEADER);
    Info.bmiHeader.biWidth = width = Bmp.bmWidth;
    Info.bmiHeader.biHeight = height = Bmp.bmHeight;
    Info.bmiHeader.biPlanes = 1;
    Info.bmiHeader.biBitCount = Bmp.bmBitsPixel;
    Info.bmiHeader.biCompression = BI_RGB;
    Info.bmiHeader.biSizeImage = ((width * Bmp.bmBitsPixel + 31) / 32) * 4 * height;

    Pixels.resize(Info.bmiHeader.biSizeImage);
    GetDIBits(DC, BitmapHandle, 0, height, &Pixels[0], &Info, DIB_RGB_COLORS);
    SelectObject(DC, OldBitmap);

    height = std::abs(height);
    DeleteDC(DC);
    return Pixels;
}

void
AirspaceLook::Reinitialise(const AirspaceRendererSettings &settings)
{
  for (unsigned i = 0; i < AIRSPACECLASSCOUNT; ++i)
    classes[i].Initialise(settings.classes[i]);
}

#if _AUG
//#   include <filesystem>  // C++17
// #   include <boost/filesystem.hpp>  // C++17
#   include <fstream>
#   include "OS/Path.hpp"
#endif

void
AirspaceLook::Initialise(const AirspaceRendererSettings &settings,
                         const Font &_name_font)
{
  Reinitialise(settings);

  // airspace brushes and colors
#ifdef HAVE_HATCHED_BRUSH

#if _AUG_TEST
  // if (bitmaps[0].Load(IDB_AIRSPACE0)) {
  Path mypath(reinterpret_cast< Path::const_pointer>(_T("D:\\Projects\\Gliding\\XCSoarAug\\Data\\bitmaps\\")));
  if (bitmaps[0].LoadFile(mypath + _T("airspace0.bmp"))) {
      Bitmap bm = bitmaps[0];
      HBITMAP hbm = bm.GetNative();
      std::fstream myfile;
      myfile = std::fstream("D:\\Airspace0.dat", std::ios::out | std::ios::binary);
      int64_t i = bm.GetWidth();
      myfile.write((char*)&i, 8);
      // myfile.write((char*)bm.GetNative(), bm.GetWidth() * bm.GetHeight());
      i = bm.GetHeight();
      myfile.write((char*)&i, 8);
      // Here would be some error handling
      myfile.write("Airspace0", 9);

      int w = 4;
      int h = 4;
      // std::vector<unsigned char> test = ToPixels(hbm, w, h);
      // myfile.write((char*)&test[0], 64);  // bm.GetWidth() * bm.GetHeight());
      myfile.write((char*)&hbm, 64);  // bm.GetWidth() * bm.GetHeight());
      
      myfile.close();
  } else {
      std::fstream myfile;
      myfile = std::fstream("D:\\Airspace0.dat", std::ios::out | std::ios::binary);
      myfile.write("Airspace0 is not defined!", 25);
      myfile.close();
  }
#endif

#if _AUG__
  if (bitmaps[1].Load(IDB_AIRSPACE1)) {
      Bitmap bm = bitmaps[1];
      std::fstream myfile;
      myfile = std::fstream("D:\\Airspace1.dat", std::ios::out | std::ios::binary);
      // Here would be some error handling
      myfile.write("Airspace1", 9);
      int64_t i = bm.GetWidth();
      myfile.write((char*)&i, 8);
      // myfile.write((char*)bm.GetNative(), bm.GetWidth() * bm.GetHeight());
      i = bm.GetHeight();
      myfile.write((char*)&i, 8);
      myfile.close();
  } else {
      std::fstream myfile;
      myfile = std::fstream("D:\\Airspace1.dat", std::ios::out | std::ios::binary);
      myfile.write("Airspace1 is not defined!", 25);
      myfile.close();
  }
#endif

#if _AUGX
//  for (int i = 1; i < 8; i++) {
//    if (bitmaps[0].LoadFile(mypath + _T("airspace") + std::to_wstring(i) + ".bmp").c_str()))) {}
//  }
    if (bitmaps[0].LoadFile(mypath + _T("airspace0.bmp"))) {}
    if (bitmaps[1].LoadFile(mypath + _T("airspace1.bmp"))) {}
    if (bitmaps[2].LoadFile(mypath + _T("airspace2.bmp"))) {}
    if (bitmaps[3].LoadFile(mypath + _T("airspace3.bmp"))) {}
    if (bitmaps[4].LoadFile(mypath + _T("airspace4.bmp"))) {}
    if (bitmaps[5].LoadFile(mypath + _T("airspace5.bmp"))) {}
    if (bitmaps[6].LoadFile(mypath + _T("airspace6.bmp"))) {}
    if (bitmaps[7].LoadFile(mypath + _T("airspace7.bmp"))) {}

#else
  bitmaps[0].Load(IDB_AIRSPACE0);
  bitmaps[1].Load(IDB_AIRSPACE1);
  bitmaps[2].Load(IDB_AIRSPACE2);
  bitmaps[3].Load(IDB_AIRSPACE3);
  bitmaps[4].Load(IDB_AIRSPACE4);
  bitmaps[5].Load(IDB_AIRSPACE5);
  bitmaps[6].Load(IDB_AIRSPACE6);
  bitmaps[7].Load(IDB_AIRSPACE7);
#endif
#if 0 // _AUG_MSC  // zur zeit nicht möglich!
  AirspaceRendererSettings s = settings;  // only as placeholder (_AUG)
  // TODO(aug)   // das BRUSH::Create geht nicht weil bitmaps == nullptr;
  // weil PNG sich nicht laden lassen!!!!
#else
  for (unsigned i = 0; i < ARRAY_SIZE(AirspaceLook::brushes); i++)
    brushes[i].Create(bitmaps[i]);
#endif
#endif

  thick_pen.Create(Layout::ScalePenWidth(10), COLOR_BLACK);

  intercept_icon.LoadResource(IDB_AIRSPACEI, IDB_AIRSPACEI_HD);

  // labels
  label_pen.Create(1, COLOR_BLUE);
  label_brush.Create(COLOR_WHITE);
  label_text_color = COLOR_BLUE;

  name_font = &_name_font;
}

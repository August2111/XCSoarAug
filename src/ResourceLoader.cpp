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

#include "ResourceLoader.hpp"
#include "ResourceId.hpp"

#include <assert.h>

#ifdef USE_WIN32_RESOURCES
#include <string>
#include "Util/Compiler.h"   // <windows.h>

#define WITH_BOOST_GIL    1
#if WITH_BOOST_GIL
#   include <iostream>
#   include "boost/gil/extension/io/png.hpp"
#   include "boost/gil.hpp"
#   include "boost/gil/io/base.hpp"
#endif

static HINSTANCE ResourceLoaderInstance;

void
ResourceLoader::Init(HINSTANCE hInstance)
{
  assert(ResourceLoaderInstance == nullptr);

  ResourceLoaderInstance = hInstance;
}

#else /* !WIN32 */

#include "resource_data.h"
#include "Util/StringAPI.hxx"

#endif /* !WIN32 */

ResourceLoader::Data
ResourceLoader::Load(const TCHAR *name, const TCHAR *type)
{
#ifdef USE_WIN32_RESOURCES
  assert(ResourceLoaderInstance != nullptr);

  HRSRC resource = ::FindResource(ResourceLoaderInstance, name, type);
  if (resource == nullptr)
    return nullptr;

  DWORD size = ::SizeofResource(ResourceLoaderInstance, resource);
  if (size == 0)
    return nullptr;

  HGLOBAL handle = ::LoadResource(ResourceLoaderInstance, resource);
  if (handle == nullptr)
    return nullptr;

  LPVOID data = LockResource(handle);
  if (data == nullptr)
    return nullptr;

  return Data(data, size);
#else

  for (unsigned i = 0; !named_resources[i].data.IsNull(); ++i)
    if (StringIsEqual(named_resources[i].name, name))
      return named_resources[i].data;

  return nullptr;
#endif
}

#ifndef ANDROID

ResourceLoader::Data
ResourceLoader::Load(ResourceId id)
{
#ifdef USE_WIN32_RESOURCES
  return Load(MAKEINTRESOURCE((unsigned)id), RT_BITMAP);
#else
  return id;
#endif
}

#endif

#ifdef USE_WIN32_RESOURCES

#if defined(_MSC_VER)  && 0
/*
inline
bool CGdiPlusBitmapResource::Load(LPCTSTR pName, LPCTSTR pType,
  HMODULE hInst) {
  Empty();

  HRSRC hResource = ::FindResource(hInst, pName, pType);
  if (!hResource)
    return false;

  DWORD imageSize = ::SizeofResource(hInst, hResource);
  if (!imageSize)
    return false;

  const void* pResourceData = ::LockResource(::LoadResource(hInst,
    hResource));
  if (!pResourceData)
    return false;

  m_hBuffer = ::GlobalAlloc(GMEM_MOVEABLE, imageSize);
  if (m_hBuffer) {
    void* pBuffer = ::GlobalLock(m_hBuffer);
    if (pBuffer) {
      CopyMemory(pBuffer, pResourceData, imageSize);

      IStream* pStream = NULL;
      if (::CreateStreamOnHGlobal(m_hBuffer, FALSE, &pStream) == S_OK) {
        m_pBitmap = Gdiplus::Bitmap::FromStream(pStream);
        pStream->Release();
        if (m_pBitmap) {
          if (m_pBitmap->GetLastStatus() == Gdiplus::Ok)
            return true;

          delete m_pBitmap;
          m_pBitmap = NULL;
        }
      }
      m_pBitmap = NULL;
      ::GlobalUnlock(m_hBuffer);
    }
    ::GlobalFree(m_hBuffer);
    m_hBuffer = NULL;
  }
  return false;
}
System::Drawing::Image getImageFromRes(long resource_ID) {
/**/
HBITMAP
// test_gil(HBITMAP hBitmap) {
test_gil(std::string filename) {
  HBITMAP oBitmap = nullptr;
  DIBSECTION d;
/*  geht nicht !!!!!!!!!!!!!!!!!!!!!!! */
#if WITH_BOOST_GIL
//  //testing, assume rgb8_image_t in object
//  int nBytes = ::GetObject(hBitmap, sizeof(DIBSECTION), &d);
//  HEImage image(d.dsBm.bmWidth, d.dsBm.bmHeight);//, d.dsBm.bmBits,  0 ); should just be able to attach bits
//  memcpy(&image.g_image._view[0], d.dsBm.bmBits,
//    d.dsBmih.biSizeImage);
//  //gil::jpeg_read_image("C:\\cpp\\HE_9\\jpeg-8c\\GIL_test\\In\\IMG_0006.JPG", image.g_image );
//
//  HEImage image2(d.dsBm.bmWidth, d.dsBm.bmHeight);
//  //testing, just flip image...
//  gil::copy_pixels(gil::rotated180_view(image.g_image._view),
//    image2.g_image._view);

  boost::gil::rgb8_image_t image;
//  boost::gil::read_image("D:\\Projects\\Gliding\\XCSoarAug\\output\\data\\bitmaps\\aboveterrain.png",
  try {
    boost::gil::read_image(filename, image, boost::gil::png_tag());
  }
  catch (...) {
    std::cout << "boost exception!" << std::endl;
  }

  if (image.width() > 0) {
    BITMAPINFO bi24BitInfo; //testing, populate to match rgb8_image_t
    memset(&bi24BitInfo, 0, sizeof(BITMAPINFO));
    bi24BitInfo.bmiHeader.biSize = sizeof(bi24BitInfo.bmiHeader);
    bi24BitInfo.bmiHeader.biBitCount = 24; // rgb 8 bytes for each  component(3)
    bi24BitInfo.bmiHeader.biCompression = BI_RGB;// rgb = 3 components
    bi24BitInfo.bmiHeader.biPlanes = 1;
    bi24BitInfo.bmiHeader.biWidth = image.width(); // = d.dsBm.bmWidth
    bi24BitInfo.bmiHeader.biHeight = image.height();  //  = d.dsBm.bmHeight

    oBitmap = ::CreateDIBSection(NULL, &bi24BitInfo,
      DIB_RGB_COLORS, 0, 0, 0);

    uint32_t nBytes = ::GetObject(oBitmap, sizeof(DIBSECTION), &d);

#if 1
    memcpy(d.dsBm.bmBits, &image, d.dsBmih.biSizeImage);
#else
    for (size_t l = image.height(); l-- > 0 ; ) {
      memcpy((char*)d.dsBm.bmBits + l * d.dsBmih.biBitCount * image.width(),
        &image, d.dsBmih.biBitCount * image.width());
    }
#endif
    /*   */
  }
#endif  // WITH_BOOST_GIL

  return oBitmap;
}

HBITMAP
getImageFromRes(HMODULE hInst, long resource_ID) {
  // Function getImageFromRes
  // A function for loading PNG images from resources in C++ CLR/CLI
  // Copyright (C) Giuseppe Pischedda 2007 for most code
  // and a little part of this code by Bordon and adapted by me for PNG images in C++ CLR/CLI.
  HBITMAP bitmap = nullptr;

  //Load the resource module:
//  HMODULE hInst = NULL;

  // Find the resource using the resource ID from file "resource.h"
//  HRSRC hResource = ::FindResource(hInst, MAKEINTRESOURCE(resource_ID), "PNG");
  // using namespace boost::gil;
  // boost::gil::image_read_settings<png_t> readSettings;
//////  boost::gil::rgb8_image_t newImage;
//////  boost::gil::read_image("D:\\Projects\\Gliding\\XCSoarAug\\output\\data\\bitmaps\\aboveterrain.png",
//////    newImage, boost::gil::png_tag());
//////
//////  HRSRC hResource = ::FindResource(hInst, "D:\\Projects\\Gliding\\XCSoarAug\\output\\data\\bitmaps\\aboveterrain.png", "PNG");
//////  if (!hResource) return nullptr;
//////
//////  // Load the resource and save the total size.
//////  DWORD Size = SizeofResource(hInst, hResource);
//////  HGLOBAL MemoryHandle = LoadResource(hInst, hResource);
//////  if (MemoryHandle == NULL) return nullptr;
//////
//////  bitmap = (HBITMAP)MemoryHandle;
//////
//////  if (bitmap->unused)
//////    bitmap = nullptr;
  std::string png_filename = "D:\\Projects\\Gliding\\XCSoarAug\\output\\data\\bitmaps\\";

#define IDB_ABOVETERRAIN 321
#define IDB_AIRSPACE    235
#define IDB_AIRSPACE0   240
#define IDB_AIRSPACE1   241
#define IDB_AIRSPACE2   242
#define IDB_AIRSPACE3   280
#define IDB_AIRSPACE4   306
#define IDB_AIRSPACE5   311
#define IDB_AIRSPACE6   317
#define IDB_AIRSPACE7   318
  switch (resource_ID) {
    case IDB_AIRSPACE: png_filename +="airspace.png"; break;
    case IDB_AIRSPACE0: png_filename +="airspace0.png"; break;
      case IDB_AIRSPACE1: png_filename +="airspace1.png"; break;
      case IDB_AIRSPACE2: png_filename +="airspace2.png"; break;
      case IDB_AIRSPACE3: png_filename +="airspace3.png"; break;
      case IDB_AIRSPACE4: png_filename +="airspace4.png"; break;
      case IDB_AIRSPACE5: png_filename +="airspace5.png"; break;
      case IDB_AIRSPACE6: png_filename +="airspace6.png"; break;
      case IDB_AIRSPACE7: png_filename +="airspace7.png"; break;
      default: png_filename += "aboveterrain.png"; break;

  }
  bitmap = test_gil(png_filename);
  /*/
  //Create a cli::array of byte with size = total size + 2
  cli::array<BYTE>^ MemPtr = gcnew array<BYTE>(Size + 2);

  //Cast from LPVOID to char *
  char* lkr = (char*)(LockResource(MemoryHandle));

  //Copy from unmanaged memory to managed array
  System::Runtime::InteropServices::Marshal::Copy((IntPtr)lkr, MemPtr, 0, Size);

  // Create a new MemoryStream with size = MemPtr
  System::IO::MemoryStream^ stream = gcnew System::IO::MemoryStream(MemPtr);

  //Write in the MemoryStream
  stream->Write(MemPtr, 0, Size);

  //Set the position for read the stream
  stream->Position = 0;

  //Free allocated resources
  FreeLibrary(hInst);

  //Create an Image abstract class pointer
  System::Drawing::Image^ ptrPNG;

  //Assign the stream to abstract class pointer
  ptrPNG = System::Drawing::Image::FromStream(stream);
  return ptrPNG;
  /**/
  return bitmap;
}


HBITMAP
ResourceLoader::LoadBitmap2(ResourceId id)
{
  HBITMAP bitmap = ::LoadBitmap(ResourceLoaderInstance, MAKEINTRESOURCE((unsigned)id));
 
  // ::LoadResource()
//  char str[0x1000];
//  strcpy(str, MAKEINTRESOURCE((unsigned)id));
  if (bitmap == nullptr) {
    bitmap = getImageFromRes(ResourceLoaderInstance, (unsigned)id);
//     CImage::Load();
//       .Pass the CImage to m_staticLogo.SetBitmap().
//    LPSTR str = MAKEINTRESOURCE((unsigned)id);
//    HANDLE hImage = ::LoadImage(ResourceLoaderInstance, MAKEINTRESOURCE((unsigned)id), 0, 10, 10, 0);
//    bitmap = nullptr;
  }
  return bitmap;
}
#else
HBITMAP
ResourceLoader::LoadBitmap2(ResourceId id) {
  return ::LoadBitmap(ResourceLoaderInstance, MAKEINTRESOURCE((unsigned)id));
}
#endif
#endif



// echte Kopie vom RC-File
#if !defined(ANDROID) || defined(ANDROID_DRAWABLE)
#   define BITMAP(name, path)    name BITMAP DISCARDABLE  path
#   define BITMAPX(name, path)   name BITMAP DISCARDABLE path
#else
/* on Android, these are included as drawable resources (PNG) */
#   define BITMAP(name, path)
#endif

// Test-Macros _AUG!
#ifdef _WIN32
#   define BOOST_PP_STRINGIZE(text)   BOOST_PP_STRINGIZE_A((text))
#   define BOOST_PP_STRINGIZE_A(arg) BOOST_PP_STRINGIZE_I arg
#   define BOOST_PP_STRINGIZE_I(text) #text

#   define CONCAT_FILENAME(a, b, c)  a##b##c
#   define BITMAP_BITMAP(name, file) BITMAP(name, "bitmaps/" file ".bmp")

#   define CONCAT(a,b) a##b
#   define STRINGIZE_(x) #x
#   define STRINGIZE(x) STRINGIZE_(x)

#define RPATH(file) "../output/data/icons/" ## file ## ".bmp"

// das brauche ich wieder:
// #define BITMAP_ICON(name, file) BITMAP(name, CONCAT_FILENAME("../output/data/icons/" , file , ".bmp"))
// #define BITMAP_ICON(name, file) BITMAP(name, ../output/data/icons/ ##  file ## .bmp)
// #define BITMAP_ICON(name, file) BITMAP(name, RPATH(file))
// #define BITMAP_ICON(name, file)  name  BITMAP DISCARDABLE #file
// #define BITMAP_ICON(name, file) BITMAP(name, file)

// #define BITMAP_TEST(name, file) BITMAPX(name, STRINGIZE(file))
// BITMAP_TEST(IDB_ABORT_HD, ../output/data/icons/ ## mode_abort_160 ## .bmp)
// BITMAP_TEST2(file)    BITMAPX(IDB_ABORT_HD, "../output/data/icons/"  file  ".bmp")
// BITMAP_TEST2("abc")
// BITMAP(IDB_ABORT_HD, "..\\output\\data\\icons\\mode_abort_160.bmp")
#endif  // _WIN32



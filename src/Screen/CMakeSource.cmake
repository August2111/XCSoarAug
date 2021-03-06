set(Screen_SOURCES
        Screen/BufferCanvas.cpp
        Screen/BufferWindow.cpp
        Screen/Canvas.cpp
        Screen/Color.cpp
        Screen/Debug.cpp
        Screen/DoubleBufferWindow.cpp
        Screen/Icon.cpp
        Screen/Layout.cpp
        Screen/ProgressBar.cpp
        Screen/Ramp.cpp
        Screen/SingleWindow.cpp
        Screen/SolidContainerWindow.cpp
        Screen/TerminalWindow.cpp
        Screen/Util.cpp
        Screen/Window.cpp
)

if(UNIX)  # OpenGL
  list(APPEND Screen_SOURCES
        Screen/FreeType/Font.cpp
        Screen/FreeType/Init.cpp
        Screen/X11/TopWindow.cpp
        Screen/Custom/Cache.cpp
        Screen/OpenGL/Init.cpp
        Screen/OpenGL/Dynamic.cpp
        Screen/OpenGL/Rotate.cpp
        Screen/OpenGL/Geo.cpp
        Screen/OpenGL/Globals.cpp
        Screen/OpenGL/Extension.cpp
        Screen/OpenGL/FBO.cpp
        Screen/OpenGL/VertexArray.cpp
        Screen/OpenGL/ConstantAlpha.cpp
        Screen/OpenGL/Bitmap.cpp
        Screen/OpenGL/RawBitmap.cpp
        Screen/OpenGL/Canvas.cpp
        Screen/OpenGL/BufferCanvas.cpp
        Screen/OpenGL/TopCanvas.cpp
        Screen/OpenGL/SubCanvas.cpp
        Screen/OpenGL/Texture.cpp
        Screen/OpenGL/UncompressedImage.cpp
        Screen/OpenGL/Buffer.cpp
        Screen/OpenGL/Shapes.cpp
        Screen/OpenGL/Surface.cpp
        Screen/OpenGL/Shaders.cpp
        Screen/OpenGL/Triangulate.cpp
        Screen/Custom/LibPNG.cpp
        Screen/Custom/LibJPEG.cpp
        Screen/Custom/LibTiff.cpp
        Screen/Custom/DoubleClick.cpp
        Screen/Custom/GeoBitmap.cpp
        Screen/Custom/Pen.cpp
        Screen/Custom/LargeTextWindow.cpp
        Screen/Custom/Window.cpp
        Screen/Custom/WList.cpp
        Screen/Custom/ContainerWindow.cpp
        Screen/Custom/TopWindow.cpp
        Screen/Custom/SingleWindow.cpp
        Screen/Custom/MoreCanvas.cpp
        Screen/Custom/Files.cpp
        Screen/Custom/Bitmap.cpp
        Screen/Custom/ResourceBitmap.cpp
        Screen/GLX/Init.cpp
        Screen/GLX/TopCanvas.cpp
        Screen/FB/Window.cpp
        Screen/FB/TopWindow.cpp
        Screen/FB/SingleWindow.cpp
  )
elseif(WIN32)  # GDI
  list(APPEND Screen_SOURCES
        Screen/GDI/Bitmap.cpp
        Screen/GDI/Brush.cpp
        Screen/GDI/BufferCanvas.cpp
        Screen/GDI/Canvas.cpp
        Screen/GDI/ContainerWindow.cpp
        Screen/GDI/Font.cpp
        Screen/GDI/Init.cpp
        Screen/GDI/LargeTextWindow.cpp
        Screen/GDI/PaintCanvas.cpp
        Screen/GDI/PaintWindow.cpp
        Screen/GDI/Pen.cpp
        Screen/GDI/RawBitmap.cpp
        Screen/GDI/ResourceBitmap.cpp
        Screen/GDI/SingleWindow.cpp
#        Screen/GDI/Timer.cpp
        Screen/GDI/TopWindow.cpp
        Screen/GDI/VirtualCanvas.cpp
        Screen/GDI/Window.cpp
        Screen/GDI/WindowCanvas.cpp
  )
endif()



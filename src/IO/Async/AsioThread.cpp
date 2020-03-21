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

#if  _AUG
  // BOOST_ASIO_SEPARATE_COMPILATION und das include-file sokll nur 1x im Project aufgerufen werden (also auch nicht
  // in einem Header-File..! Deshalb habe ich es jetzt hier abgelegt, möglicherweise 
#endif
// #define BOOST_ASIO_SEPARATE_COMPILATION
#include <boost/asio/impl/src.hpp>
#include "AsioThread.hpp"

bool
AsioThread::Start()
{
  assert(!IsDefined());

  return Thread::Start();
}

void
AsioThread::Stop()
{
  /* set the "stop" flag and wake up the thread */
  io_context.stop();

  /* wait for the thread to finish */
  Join();
}

void
AsioThread::Run() noexcept
{
  /* a dummy work to keep the io_context alive even if we're
     completely idle */
  boost::asio::io_context::work work(io_context);

  io_context.run();
}


#if 0 // _AUG
#include "GlobalAsioThread.hpp"
// #include "AsioThread.hpp"

AsioThread* asio_thread;

void
InitialiseAsioThread() {
  assert(asio_thread == nullptr);

  asio_thread = new AsioThread();
  asio_thread->Start();
}

void
DeinitialiseAsioThread() {
  asio_thread->Stop();
  delete asio_thread;
  asio_thread = nullptr;
}
#endif

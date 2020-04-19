/*
 * Copyright (C) 2009-2015 Max Kellermann <max.kellermann@gmail.com>
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 * notice, this list of conditions and the following disclaimer.
 *
 * - Redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in the
 * documentation and/or other materials provided with the
 * distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE
 * FOUNDATION OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#ifndef THREAD_WINDOWS_SHARED_MUTEX_HXX
#define THREAD_WINDOWS_SHARED_MUTEX_HXX

#include "Util/Compiler.h"   // <windows.h>

 /**
  * Low-level wrapper for a SRWLOCK.
  */
class WindowsSharedMutex {
  SRWLOCK srwlock = SRWLOCK_INIT;

public:
  constexpr WindowsSharedMutex() = default;

  WindowsSharedMutex(const WindowsSharedMutex& other) = delete;
  WindowsSharedMutex& operator=(const WindowsSharedMutex& other) = delete;

  void lock() {
#ifdef MSVC
    AcquireSRWLockExclusive(&srwlock);
#else
    // TODO(aug): !!!AcquireSRWLockExclusive(&srwlock);
#endif
  }

  bool try_lock() {
#ifdef MSVC
    return TryAcquireSRWLockExclusive(&srwlock);
#else
    return false;
    // TODO(aug): !!!return TryAcquireSRWLockExclusive(&srwlock);
#endif
  }

  void unlock() {
#ifdef MSVC
    ReleaseSRWLockExclusive(&srwlock);
#else
    // TODO(aug): !!!ReleaseSRWLockExclusive(&srwlock);
#endif
  }

  void lock_shared() {
#ifdef MSVC
    AcquireSRWLockShared(&srwlock);
#else
    // TODO(aug): !!!AcquireSRWLockShared(&srwlock);
#endif
  }

  bool try_lock_shared() {
#ifdef MSVC
      return TryAcquireSRWLockShared(&srwlock);
#else
      return false;
      // TODO(aug): !!!return TryAcquireSRWLockShared(&srwlock);
#endif
  }

  void unlock_shared() {
#ifdef MSVC
    ReleaseSRWLockShared(&srwlock);
#else
    // TODO(aug): !!!ReleaseSRWLockShared(&srwlock);
#endif
  }
};

#endif

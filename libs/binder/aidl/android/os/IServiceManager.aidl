/*
 * Copyright (C) 2006 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package android.os;

/**
 * Basic interface for finding and publishing system services.
 *
 * You likely want to use android.os.ServiceManager in Java or
 * android::IServiceManager in C++ in order to use this interface.
 *
 * @hide
 */
interface IServiceManager {
    /*
     * Must update values in IServiceManager.h
     */
    /* Allows services to dump sections according to priorities. */
    const int DUMP_FLAG_PRIORITY_CRITICAL = 1; // 1 << 0
    const int DUMP_FLAG_PRIORITY_HIGH = 2; // 1 << 1
    const int DUMP_FLAG_PRIORITY_NORMAL = 4; // 1 << 2
    /**
     * Services are by default registered with a DEFAULT dump priority. DEFAULT priority has the
     * same priority as NORMAL priority but the services are not called with dump priority
     * arguments.
     */
    const int DUMP_FLAG_PRIORITY_DEFAULT = 8; // 1 << 3

    const int DUMP_FLAG_PRIORITY_ALL = 15;
             // DUMP_FLAG_PRIORITY_CRITICAL | DUMP_FLAG_PRIORITY_HIGH
             // | DUMP_FLAG_PRIORITY_NORMAL | DUMP_FLAG_PRIORITY_DEFAULT;

    /* Allows services to dump sections in protobuf format. */
    const int DUMP_FLAG_PROTO = 16; // 1 << 4

    /**
     * Retrieve an existing service called @a name from the
     * service manager.
     *
     * This is the same as checkService (returns immediately) but
     * exists for legacy purposes.
     *
     * Returns null if the service does not exist.
     */
    @UnsupportedAppUsage
    IBinder getService(@utf8InCpp String name);

    /**
     * Retrieve an existing service called @a name from the service
     * manager. Non-blocking. Returns null if the service does not
     * exist.
     */
    @UnsupportedAppUsage
    IBinder checkService(@utf8InCpp String name);

    /**
     * Place a new @a service called @a name into the service
     * manager.
     */
    void addService(@utf8InCpp String name, IBinder service,
        boolean allowIsolated, int dumpPriority);

    /**
     * Return a list of all currently running services.
     */
    @utf8InCpp String[] listServices(int dumpPriority);
}

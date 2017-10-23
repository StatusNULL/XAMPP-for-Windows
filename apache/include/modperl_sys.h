/* Copyright 2002-2004 The Apache Software Foundation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef MODPERL_SYS_H
#define MODPERL_SYS_H

/*
 * system specific type stuff.
 * hopefully won't be much here since Perl/APR/Apache
 * take care of most portablity issues.
 */

int modperl_sys_is_dir(pTHX_ SV *sv);

int modperl_sys_dlclose(void *handle);

#endif /* MODPERL_SYS_H */

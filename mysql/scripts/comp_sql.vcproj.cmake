<?xml version="1.0" encoding = "Windows-1252"?>
<VisualStudioProject
	ProjectType="Visual C++"
	Version="7.10"
	Name="comp_sql"
	SccProjectName=""
	SccLocalPath=""
	Keyword="Win32Proj">
	<Platforms>
		<Platform
			Name="Win32"/>
	</Platforms>
	<Configurations>
		<Configuration
			Name="Debug|Win32"
			OutputDirectory="Debug"
			IntermediateDirectory="comp_sql.dir\Debug"
			ConfigurationType="1"
			UseOfMFC="0"
			ATLMinimizesCRunTimeLibraryUsage="FALSE"
			CharacterSet="2">
			<Tool
				Name="VCCLCompilerTool"
				AdditionalOptions=" /Zm1000"
				AdditionalIncludeDirectories=""
				BasicRuntimeChecks="1"
				CompileAs="1"
				DebugInformationFormat="3"
				ExceptionHandling="FALSE"
				InlineFunctionExpansion="0"
				Optimization="0"
				RuntimeLibrary="1"
				WarningLevel="3"
				PreprocessorDefinitions="WIN32,_WINDOWS,_DEBUG,CMAKE_BUILD,HAVE_YASSL,HAVE_ARCHIVE_DB,HAVE_BLACKHOLE_DB,HAVE_FEDERATED_DB,HAVE_INNOBASE_DB,__NT__,_WINDOWS,__WIN__,_CRT_SECURE_NO_DEPRECATE,&quot;CMAKE_INTDIR=\&quot;Debug\&quot;&quot;"
				AssemblerListingLocation="Debug"
				ObjectFile="$(IntDir)\"
				ProgramDataBaseFileName="F:/build/mysql-5.0.51b-winbuild/mysql-community-nt-5.0.51b-build/scripts/Debug/comp_sql.pdb"
/>
			<Tool
				Name="VCCustomBuildTool"/>
			<Tool
				Name="VCResourceCompilerTool"
				AdditionalIncludeDirectories=""
				PreprocessorDefinitions="WIN32,_WINDOWS,_DEBUG,CMAKE_BUILD,HAVE_YASSL,HAVE_ARCHIVE_DB,HAVE_BLACKHOLE_DB,HAVE_FEDERATED_DB,HAVE_INNOBASE_DB,__NT__,_WINDOWS,__WIN__,_CRT_SECURE_NO_DEPRECATE,&quot;CMAKE_INTDIR=\&quot;Debug\&quot;&quot;"/>
			<Tool
				Name="VCMIDLTool"
				PreprocessorDefinitions="WIN32,_WINDOWS,_DEBUG,CMAKE_BUILD,HAVE_YASSL,HAVE_ARCHIVE_DB,HAVE_BLACKHOLE_DB,HAVE_FEDERATED_DB,HAVE_INNOBASE_DB,__NT__,_WINDOWS,__WIN__,_CRT_SECURE_NO_DEPRECATE,&quot;CMAKE_INTDIR=\&quot;Debug\&quot;&quot;"
				MkTypLibCompatible="FALSE"
				TargetEnvironment="1"
				GenerateStublessProxies="TRUE"
				TypeLibraryName="$(InputName).tlb"
				OutputDirectory="$(IntDir)"
				HeaderFileName="$(InputName).h"
				DLLDataFileName=""
				InterfaceIdentifierFileName="$(InputName)_i.c"
				ProxyFileName="$(InputName)_p.c"/>
			<Tool
				Name="VCPreBuildEventTool"/>
			<Tool
				Name="VCPreLinkEventTool"/>
			<Tool
				Name="VCPostBuildEventTool"/>
			<Tool
				Name="VCLinkerTool"
				AdditionalOptions=" /STACK:10000000 /machine:I386 /MAP /MAPINFO:EXPORTS /STACK:1048576 /debug"
				AdditionalDependencies="$(NOINHERIT) kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib dbug.lib mysys.lib strings.lib "
				OutputFile="Debug\comp_sql.exe"
				Version="0.0"
				GenerateManifest="FALSE"
				LinkIncremental="2"
				AdditionalLibraryDirectories="..\dbug\$(OutDir),..\dbug,..\mysys\$(OutDir),..\mysys,..\strings\$(OutDir),..\strings"
				ProgramDataBaseFile="$(OutDir)\comp_sql.pdb"
				GenerateDebugInformation="TRUE"
				SubSystem="1"
/>
		</Configuration>
		<Configuration
			Name="Release|Win32"
			OutputDirectory="Release"
			IntermediateDirectory="comp_sql.dir\Release"
			ConfigurationType="1"
			UseOfMFC="0"
			ATLMinimizesCRunTimeLibraryUsage="FALSE"
			CharacterSet="2">
			<Tool
				Name="VCCLCompilerTool"
				AdditionalOptions=" /Zm1000"
				AdditionalIncludeDirectories=""
				CompileAs="1"
				ExceptionHandling="FALSE"
				InlineFunctionExpansion="2"
				Optimization="2"
				RuntimeLibrary="0"
				WarningLevel="3"
				PreprocessorDefinitions="WIN32,_WINDOWS,NDEBUG,DBUG_OFF,CMAKE_BUILD,HAVE_YASSL,HAVE_ARCHIVE_DB,HAVE_BLACKHOLE_DB,HAVE_FEDERATED_DB,HAVE_INNOBASE_DB,__NT__,_WINDOWS,__WIN__,_CRT_SECURE_NO_DEPRECATE,&quot;CMAKE_INTDIR=\&quot;Release\&quot;&quot;"
				AssemblerListingLocation="Release"
				ObjectFile="$(IntDir)\"
				ProgramDataBaseFileName="F:/build/mysql-5.0.51b-winbuild/mysql-community-nt-5.0.51b-build/scripts/Release/comp_sql.pdb"
/>
			<Tool
				Name="VCCustomBuildTool"/>
			<Tool
				Name="VCResourceCompilerTool"
				AdditionalIncludeDirectories=""
				PreprocessorDefinitions="WIN32,_WINDOWS,NDEBUG,DBUG_OFF,CMAKE_BUILD,HAVE_YASSL,HAVE_ARCHIVE_DB,HAVE_BLACKHOLE_DB,HAVE_FEDERATED_DB,HAVE_INNOBASE_DB,__NT__,_WINDOWS,__WIN__,_CRT_SECURE_NO_DEPRECATE,&quot;CMAKE_INTDIR=\&quot;Release\&quot;&quot;"/>
			<Tool
				Name="VCMIDLTool"
				PreprocessorDefinitions="WIN32,_WINDOWS,NDEBUG,DBUG_OFF,CMAKE_BUILD,HAVE_YASSL,HAVE_ARCHIVE_DB,HAVE_BLACKHOLE_DB,HAVE_FEDERATED_DB,HAVE_INNOBASE_DB,__NT__,_WINDOWS,__WIN__,_CRT_SECURE_NO_DEPRECATE,&quot;CMAKE_INTDIR=\&quot;Release\&quot;&quot;"
				MkTypLibCompatible="FALSE"
				TargetEnvironment="1"
				GenerateStublessProxies="TRUE"
				TypeLibraryName="$(InputName).tlb"
				OutputDirectory="$(IntDir)"
				HeaderFileName="$(InputName).h"
				DLLDataFileName=""
				InterfaceIdentifierFileName="$(InputName)_i.c"
				ProxyFileName="$(InputName)_p.c"/>
			<Tool
				Name="VCPreBuildEventTool"/>
			<Tool
				Name="VCPreLinkEventTool"/>
			<Tool
				Name="VCPostBuildEventTool"/>
			<Tool
				Name="VCLinkerTool"
				AdditionalOptions=" /STACK:10000000 /machine:I386 /MAP /MAPINFO:EXPORTS /STACK:1048576"
				AdditionalDependencies="$(NOINHERIT) kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib mysys.lib strings.lib "
				OutputFile="Release\comp_sql.exe"
				Version="0.0"
				GenerateManifest="FALSE"
				LinkIncremental="1"
				AdditionalLibraryDirectories="..\dbug\$(OutDir),..\dbug,..\mysys\$(OutDir),..\mysys,..\strings\$(OutDir),..\strings"
				ProgramDataBaseFile="$(OutDir)\comp_sql.pdb"
				SubSystem="1"
/>
		</Configuration>
		<Configuration
			Name="MinSizeRel|Win32"
			OutputDirectory="MinSizeRel"
			IntermediateDirectory="comp_sql.dir\MinSizeRel"
			ConfigurationType="1"
			UseOfMFC="0"
			ATLMinimizesCRunTimeLibraryUsage="FALSE"
			CharacterSet="2">
			<Tool
				Name="VCCLCompilerTool"
				AdditionalOptions=" /Zm1000"
				AdditionalIncludeDirectories=""
				CompileAs="1"
				ExceptionHandling="FALSE"
				InlineFunctionExpansion="1"
				Optimization="1"
				RuntimeLibrary="2"
				WarningLevel="3"
				PreprocessorDefinitions="WIN32,_WINDOWS,NDEBUG,CMAKE_BUILD,HAVE_YASSL,HAVE_ARCHIVE_DB,HAVE_BLACKHOLE_DB,HAVE_FEDERATED_DB,HAVE_INNOBASE_DB,__NT__,_WINDOWS,__WIN__,_CRT_SECURE_NO_DEPRECATE,&quot;CMAKE_INTDIR=\&quot;MinSizeRel\&quot;&quot;"
				AssemblerListingLocation="MinSizeRel"
				ObjectFile="$(IntDir)\"
				ProgramDataBaseFileName="F:/build/mysql-5.0.51b-winbuild/mysql-community-nt-5.0.51b-build/scripts/MinSizeRel/comp_sql.pdb"
/>
			<Tool
				Name="VCCustomBuildTool"/>
			<Tool
				Name="VCResourceCompilerTool"
				AdditionalIncludeDirectories=""
				PreprocessorDefinitions="WIN32,_WINDOWS,NDEBUG,CMAKE_BUILD,HAVE_YASSL,HAVE_ARCHIVE_DB,HAVE_BLACKHOLE_DB,HAVE_FEDERATED_DB,HAVE_INNOBASE_DB,__NT__,_WINDOWS,__WIN__,_CRT_SECURE_NO_DEPRECATE,&quot;CMAKE_INTDIR=\&quot;MinSizeRel\&quot;&quot;"/>
			<Tool
				Name="VCMIDLTool"
				PreprocessorDefinitions="WIN32,_WINDOWS,NDEBUG,CMAKE_BUILD,HAVE_YASSL,HAVE_ARCHIVE_DB,HAVE_BLACKHOLE_DB,HAVE_FEDERATED_DB,HAVE_INNOBASE_DB,__NT__,_WINDOWS,__WIN__,_CRT_SECURE_NO_DEPRECATE,&quot;CMAKE_INTDIR=\&quot;MinSizeRel\&quot;&quot;"
				MkTypLibCompatible="FALSE"
				TargetEnvironment="1"
				GenerateStublessProxies="TRUE"
				TypeLibraryName="$(InputName).tlb"
				OutputDirectory="$(IntDir)"
				HeaderFileName="$(InputName).h"
				DLLDataFileName=""
				InterfaceIdentifierFileName="$(InputName)_i.c"
				ProxyFileName="$(InputName)_p.c"/>
			<Tool
				Name="VCPreBuildEventTool"/>
			<Tool
				Name="VCPreLinkEventTool"/>
			<Tool
				Name="VCPostBuildEventTool"/>
			<Tool
				Name="VCLinkerTool"
				AdditionalOptions=" /STACK:10000000 /machine:I386 /MAP /MAPINFO:EXPORTS /STACK:1048576"
				AdditionalDependencies="$(NOINHERIT) kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib mysys.lib strings.lib "
				OutputFile="MinSizeRel\comp_sql.exe"
				Version="0.0"
				GenerateManifest="FALSE"
				LinkIncremental="1"
				AdditionalLibraryDirectories="..\dbug\$(OutDir),..\dbug,..\mysys\$(OutDir),..\mysys,..\strings\$(OutDir),..\strings"
				ProgramDataBaseFile="$(OutDir)\comp_sql.pdb"
				SubSystem="1"
/>
		</Configuration>
		<Configuration
			Name="RelWithDebInfo|Win32"
			OutputDirectory="RelWithDebInfo"
			IntermediateDirectory="comp_sql.dir\RelWithDebInfo"
			ConfigurationType="1"
			UseOfMFC="0"
			ATLMinimizesCRunTimeLibraryUsage="FALSE"
			CharacterSet="2">
			<Tool
				Name="VCCLCompilerTool"
				AdditionalOptions=" /Zm1000"
				AdditionalIncludeDirectories=""
				CompileAs="1"
				DebugInformationFormat="3"
				ExceptionHandling="FALSE"
				InlineFunctionExpansion="1"
				Optimization="2"
				RuntimeLibrary="0"
				WarningLevel="3"
				PreprocessorDefinitions="WIN32,_WINDOWS,NDEBUG,DBUG_OFF,CMAKE_BUILD,HAVE_YASSL,HAVE_ARCHIVE_DB,HAVE_BLACKHOLE_DB,HAVE_FEDERATED_DB,HAVE_INNOBASE_DB,__NT__,_WINDOWS,__WIN__,_CRT_SECURE_NO_DEPRECATE,&quot;CMAKE_INTDIR=\&quot;RelWithDebInfo\&quot;&quot;"
				AssemblerListingLocation="RelWithDebInfo"
				ObjectFile="$(IntDir)\"
				ProgramDataBaseFileName="F:/build/mysql-5.0.51b-winbuild/mysql-community-nt-5.0.51b-build/scripts/RelWithDebInfo/comp_sql.pdb"
/>
			<Tool
				Name="VCCustomBuildTool"/>
			<Tool
				Name="VCResourceCompilerTool"
				AdditionalIncludeDirectories=""
				PreprocessorDefinitions="WIN32,_WINDOWS,NDEBUG,DBUG_OFF,CMAKE_BUILD,HAVE_YASSL,HAVE_ARCHIVE_DB,HAVE_BLACKHOLE_DB,HAVE_FEDERATED_DB,HAVE_INNOBASE_DB,__NT__,_WINDOWS,__WIN__,_CRT_SECURE_NO_DEPRECATE,&quot;CMAKE_INTDIR=\&quot;RelWithDebInfo\&quot;&quot;"/>
			<Tool
				Name="VCMIDLTool"
				PreprocessorDefinitions="WIN32,_WINDOWS,NDEBUG,DBUG_OFF,CMAKE_BUILD,HAVE_YASSL,HAVE_ARCHIVE_DB,HAVE_BLACKHOLE_DB,HAVE_FEDERATED_DB,HAVE_INNOBASE_DB,__NT__,_WINDOWS,__WIN__,_CRT_SECURE_NO_DEPRECATE,&quot;CMAKE_INTDIR=\&quot;RelWithDebInfo\&quot;&quot;"
				MkTypLibCompatible="FALSE"
				TargetEnvironment="1"
				GenerateStublessProxies="TRUE"
				TypeLibraryName="$(InputName).tlb"
				OutputDirectory="$(IntDir)"
				HeaderFileName="$(InputName).h"
				DLLDataFileName=""
				InterfaceIdentifierFileName="$(InputName)_i.c"
				ProxyFileName="$(InputName)_p.c"/>
			<Tool
				Name="VCPreBuildEventTool"/>
			<Tool
				Name="VCPreLinkEventTool"/>
			<Tool
				Name="VCPostBuildEventTool"/>
			<Tool
				Name="VCLinkerTool"
				AdditionalOptions=" /STACK:10000000 /machine:I386 /MAP /MAPINFO:EXPORTS /STACK:1048576 /debug"
				AdditionalDependencies="$(NOINHERIT) kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib mysys.lib strings.lib "
				OutputFile="RelWithDebInfo\comp_sql.exe"
				Version="0.0"
				GenerateManifest="FALSE"
				LinkIncremental="2"
				AdditionalLibraryDirectories="..\dbug\$(OutDir),..\dbug,..\mysys\$(OutDir),..\mysys,..\strings\$(OutDir),..\strings"
				ProgramDataBaseFile="$(OutDir)\comp_sql.pdb"
				GenerateDebugInformation="TRUE"
				SubSystem="1"
/>
		</Configuration>
	</Configurations>
	<Files>
			<File
				RelativePath="F:\build\mysql-5.0.51b-winbuild\mysql-community-nt-5.0.51b-build\scripts\CMakeLists.txt">
				<FileConfiguration
					Name="Debug|Win32">
					<Tool
					Name="VCCustomBuildTool"
					Description="Building Custom Rule F:/build/mysql-5.0.51b-winbuild/mysql-community-nt-5.0.51b-build/scripts/CMakeLists.txt"
					CommandLine="&quot;C:\Program Files\CMake 2.4\bin\cmake.exe&quot; -HF:/build/mysql-5.0.51b-winbuild/mysql-community-nt-5.0.51b-build -BF:/build/mysql-5.0.51b-winbuild/mysql-community-nt-5.0.51b-build"
					AdditionalDependencies="F:\build\mysql-5.0.51b-winbuild\mysql-community-nt-5.0.51b-build\scripts\CMakeLists.txt;&quot;C:\Program Files\CMake 2.4\share\cmake-2.4\Templates\CMakeWindowsSystemConfig.cmake&quot;;F:\build\mysql-5.0.51b-winbuild\mysql-community-nt-5.0.51b-build\scripts\CMakeLists.txt;"
					Outputs="comp_sql.vcproj.cmake"/>
				</FileConfiguration>
				<FileConfiguration
					Name="Release|Win32">
					<Tool
					Name="VCCustomBuildTool"
					Description="Building Custom Rule F:/build/mysql-5.0.51b-winbuild/mysql-community-nt-5.0.51b-build/scripts/CMakeLists.txt"
					CommandLine="&quot;C:\Program Files\CMake 2.4\bin\cmake.exe&quot; -HF:/build/mysql-5.0.51b-winbuild/mysql-community-nt-5.0.51b-build -BF:/build/mysql-5.0.51b-winbuild/mysql-community-nt-5.0.51b-build"
					AdditionalDependencies="F:\build\mysql-5.0.51b-winbuild\mysql-community-nt-5.0.51b-build\scripts\CMakeLists.txt;&quot;C:\Program Files\CMake 2.4\share\cmake-2.4\Templates\CMakeWindowsSystemConfig.cmake&quot;;F:\build\mysql-5.0.51b-winbuild\mysql-community-nt-5.0.51b-build\scripts\CMakeLists.txt;"
					Outputs="comp_sql.vcproj.cmake"/>
				</FileConfiguration>
				<FileConfiguration
					Name="MinSizeRel|Win32">
					<Tool
					Name="VCCustomBuildTool"
					Description="Building Custom Rule F:/build/mysql-5.0.51b-winbuild/mysql-community-nt-5.0.51b-build/scripts/CMakeLists.txt"
					CommandLine="&quot;C:\Program Files\CMake 2.4\bin\cmake.exe&quot; -HF:/build/mysql-5.0.51b-winbuild/mysql-community-nt-5.0.51b-build -BF:/build/mysql-5.0.51b-winbuild/mysql-community-nt-5.0.51b-build"
					AdditionalDependencies="F:\build\mysql-5.0.51b-winbuild\mysql-community-nt-5.0.51b-build\scripts\CMakeLists.txt;&quot;C:\Program Files\CMake 2.4\share\cmake-2.4\Templates\CMakeWindowsSystemConfig.cmake&quot;;F:\build\mysql-5.0.51b-winbuild\mysql-community-nt-5.0.51b-build\scripts\CMakeLists.txt;"
					Outputs="comp_sql.vcproj.cmake"/>
				</FileConfiguration>
				<FileConfiguration
					Name="RelWithDebInfo|Win32">
					<Tool
					Name="VCCustomBuildTool"
					Description="Building Custom Rule F:/build/mysql-5.0.51b-winbuild/mysql-community-nt-5.0.51b-build/scripts/CMakeLists.txt"
					CommandLine="&quot;C:\Program Files\CMake 2.4\bin\cmake.exe&quot; -HF:/build/mysql-5.0.51b-winbuild/mysql-community-nt-5.0.51b-build -BF:/build/mysql-5.0.51b-winbuild/mysql-community-nt-5.0.51b-build"
					AdditionalDependencies="F:\build\mysql-5.0.51b-winbuild\mysql-community-nt-5.0.51b-build\scripts\CMakeLists.txt;&quot;C:\Program Files\CMake 2.4\share\cmake-2.4\Templates\CMakeWindowsSystemConfig.cmake&quot;;F:\build\mysql-5.0.51b-winbuild\mysql-community-nt-5.0.51b-build\scripts\CMakeLists.txt;"
					Outputs="comp_sql.vcproj.cmake"/>
				</FileConfiguration>
			</File>
		<Filter
			Name="Source Files"
			Filter="">
			<File
				RelativePath="F:\build\mysql-5.0.51b-winbuild\mysql-community-nt-5.0.51b-build\scripts\comp_sql.c">
			</File>
		</Filter>
	</Files>
	<Globals>
	</Globals>
</VisualStudioProject>

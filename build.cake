#addin nuget:?package=Cake.FileHelpers&version=3.2.1
#tool nuget:?package=Microsoft.DotNet.BuildTools.GenAPI&version=1.0.0-beta-00081&prerelease
#tool "nuget:?package=NuGet.CommandLine&version=5.11.0"

var DEFAULT_SN_EXE = IsRunningOnWindows()
	? GetFiles("C:/Program Files (x86)/Microsoft SDKs/Windows/v10.0A/bin/*/sn.exe").First().FullPath
	: "sn";

var TARGET = Argument("t", Argument("target", "nuget"));
var SN_EXE = Argument("sn", EnvironmentVariable("SN_EXE") ?? DEFAULT_SN_EXE);

var NUGET_VERSION = "5.20.1-preview";

Task("libs")
	.Does(() =>
{
	// build for windows
	MSBuild($"./externals/mono/mcs/class/Mono.Posix/Mono.Posix.NETStandard-netstandard_2_0.csproj", c => c
		.SetConfiguration("Release")
		.WithRestore()
		.WithTarget("Build")
		.WithProperty("DebugType", "portable")
		.WithProperty("ForceUseLibC", "false")
		.WithProperty("OutputPath", MakeAbsolute((DirectoryPath)"./working/lib/any/").FullPath));

	// build for unix
	MSBuild($"./externals/mono/mcs/class/Mono.Posix/Mono.Posix.NETStandard-netstandard_2_0.csproj", c => c
		.SetConfiguration("Release")
		.WithRestore()
		.WithTarget("Build")
		.WithProperty("DebugType", "portable")
		.WithProperty("ForceUseLibC", "true")
		.WithProperty("OutputPath", MakeAbsolute((DirectoryPath)"./working/lib/unix/").FullPath));

	// generate the type forwards
	EnsureDirectoryExists("./working/cs/");
	StartProcess(Context.Tools.Resolve("GenAPI.exe"),
		"-w:TypeForwards ./working/lib/any/Mono.Posix.NETStandard.dll -out ./working/cs/Mono.Posix.generated.cs");

	// build for the type forwards
 	MSBuild($"./source/Mono.Posix.TypeForwards.csproj", c => c
		.SetConfiguration("Release")
		.WithRestore()
		.WithTarget("Build")
		.WithProperty("OutputPath", MakeAbsolute((DirectoryPath)"./working/ref/").FullPath));

	// make sure the files are signed correctly
	foreach (var dll in GetFiles("./working/lib/*/*.dll")) {
		StartProcess(SN_EXE, $"-R {dll} ./externals/mono/mcs/class/Open.snk");
	}
});

Task("nuget")
	.IsDependentOn("libs")
	.Does(() =>
{
	NuGetPack("./nuget/Mono.Posix.NETStandard.nuspec", new NuGetPackSettings {
		BasePath = MakeAbsolute((DirectoryPath)"./").FullPath,
		OutputDirectory = "./output/",
		Version = NUGET_VERSION,
	});
});

RunTarget(TARGET);
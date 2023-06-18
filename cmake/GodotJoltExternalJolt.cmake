include_guard()

include(GodotJoltExternalLibrary)

set(configurations
	Debug
	Release
	Distribution
)

set(use_avx512 $<BOOL:${GDJ_USE_AVX512}>)
set(use_avx2 $<BOOL:${GDJ_USE_AVX2}>)
set(use_bmi1 $<BOOL:${GDJ_USE_BMI1}>)
set(use_fma3 $<BOOL:${GDJ_USE_FMA3}>)
set(use_f16c $<BOOL:${GDJ_USE_F16C}>)
set(use_avx $<BOOL:${GDJ_USE_AVX}>)
set(use_sse4_2 $<BOOL:${GDJ_USE_SSE4_2}>)
set(use_sse4_2 $<BOOL:${GDJ_USE_SSE4_2}>)

set(is_msvc_cl $<CXX_COMPILER_ID:MSVC>)

set(dev_definitions
	$<${is_msvc_cl}:JPH_FLOATING_POINT_EXCEPTIONS_ENABLED>
	JPH_PROFILE_ENABLED
	JPH_DEBUG_RENDERER
)

gdj_add_external_library(jolt "${configurations}"
	GIT_REPOSITORY https://github.com/godot-jolt/jolt.git
	GIT_COMMIT c24af412ff419c567b30ff96f6f77d85e88f5876
	LANGUAGE CXX
	SOURCE_SUBDIR Build
	OUTPUT_NAME Jolt
	INCLUDE_DIRECTORIES
		<SOURCE_DIR>
	COMPILE_DEFINITIONS
		$<${use_avx512}:JPH_USE_AVX512>
		$<${use_avx2}:JPH_USE_AVX2>
		$<${use_bmi1}:JPH_USE_TZCNT>
		$<${use_bmi1}:JPH_USE_LZCNT>
		$<${use_fma3}:JPH_USE_FMADD>
		$<${use_f16c}:JPH_USE_F16C>
		$<${use_avx}:JPH_USE_AVX>
		$<${use_sse4_2}:JPH_USE_SSE4_2>
		$<${use_sse4_2}:JPH_USE_SSE4_1>
	COMPILE_DEFINITIONS_DEBUG
		${dev_definitions}
	COMPILE_DEFINITIONS_RELEASE
		${dev_definitions}
	CMAKE_CACHE_ARGS
		-DENABLE_ALL_WARNINGS=FALSE
		-DTARGET_HELLO_WORLD=FALSE
		-DTARGET_PERFORMANCE_TEST=FALSE
		-DTARGET_SAMPLES=FALSE
		-DTARGET_UNIT_TESTS=FALSE
		-DTARGET_VIEWER=FALSE
		-DINTERPROCEDURAL_OPTIMIZATION=${GDJ_INTERPROCEDURAL_OPTIMIZATION}
		-DUSE_AVX512=${GDJ_USE_AVX512}
		-DUSE_AVX2=${GDJ_USE_AVX2}
		-DUSE_LZCNT=${GDJ_USE_BMI1}
		-DUSE_TZCNT=${GDJ_USE_BMI1}
		-DUSE_FMADD=${GDJ_USE_FMA3}
		-DUSE_F16C=${GDJ_USE_F16C}
		-DUSE_AVX=${GDJ_USE_AVX}
		-DUSE_SSE4_2=${GDJ_USE_SSE4_2}
		-DUSE_SSE4_1=${GDJ_USE_SSE4_2}
		-DUSE_STATIC_MSVC_RUNTIME_LIBRARY=${GDJ_STATIC_RUNTIME_LIBRARY}
	LIBRARY_CONFIG_DEBUG Debug
	LIBRARY_CONFIG_DEVELOPMENT Release
	LIBRARY_CONFIG_DISTRIBUTION Distribution
	LIBRARY_CONFIG_EDITORDEBUG Debug
	LIBRARY_CONFIG_EDITORDEVELOPMENT Release
	LIBRARY_CONFIG_EDITORDISTRIBUTION Release
)

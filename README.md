# Windows CMD scripts

`fcall.bat` compares files common to two directories using `fc`

`runexe.bat` runs all .exe files in the current directory, reports any that encounter runtime errors, and summarizes the results.

`nospace.bat` renames a file to remove spaces, commas, or extra hyphens in its name

`gitc.bat` classifies files as NEW, DIFFERENT, SAME based on git. For example, `gitc.bat *.f90` could give
```
NEW garch_ged.f90 garch_laplace.f90 garch_logis.f90 garch_t.f90 temp.f90 temp_garch.f90 temp_xgarch_sim.f90 tests.f90 tests_mix.f90 tfit.f90 xchar.f90 xcumsum.f90 xenv.f90 xmean_median.f90 xprint_real.f90 xqsort.f90 xrandom.f90 xread_vec.f90 xrep.f90 xreplace.f90 xtest_mssk.f90 xutil.f90 xwindows.f90 xxenv.f90 xxprint_real.f90 tmp_f90\tmp_hyperb_int.f90 tmp_f90\tmp_hyperb_norm.f90 tmp_f90\tmp_k1.f90 tmp_f90\tmp_mtspec_test.f90 tmp_f90\tmp_pg_test.f90 tmp_f90\tmp_pg_test2.f90
DIFFERENT constants.f90 gnuplot.f90 interpret.f90 mat.f90 qsort.f90 random.f90 util.f90 xfit_t.f90 xgarch_sim.f90 xgarch_sim_nonnormal.f90 xtest_dist.f90
SAME calc.f90 garch.f90 kind.f90 stats.f90 xcalc.f90 xinterpret.f90 xnoise.f90
```

class Build {
    method build($dist-path) {
        # do build stuff to your module
        # which is located at $dist-path
        dd %?RESOURCES;
        my IO::Path $CWD = $*CWD;
        my Str:D $path  = "/usr/lib/perl6/site/bin";
        my Str:D $local = "/usr/local";
        chdir($path.IO);
        my Proc $r = run 'raku',    '--doc=Man',  "Gzz::Readline.rakudoc",  :out;
        my $man-content = $r.out.slurp: :close;
        "$local/share/man".IO.mkdir();
        "$local/share/man/Gzz::Readline.1".IO.spurt($man-content);
        $r = run         'raku',    '--doc=HTML', "Gzz::Readline.rakudoc",  :out;
        my $html-content = $r.out.slurp: :close;
        "$local/share/html".IO.mkdir();
        "$local/share/html/Gzz::Readline.html".IO.spurt($html-content);

        $r = run         'apt-get', 'reinstall',  '--yes', "build-essential";
        $r = run         'apt-get', 'reinstall',  '--yes', "cmake";
        $r = run         'apt-get', 'reinstall',  '--yes', "vim-nox";
        $r = run         'apt-get', 'reinstall',  '--yes', "python3-dev";
        $r = run         'apt-get', 'reinstall',  '--yes', "mono-complete";
        $r = run         'apt-get', 'reinstall',  '--yes', "golang";
        $r = run         'apt-get', 'reinstall',  '--yes', "nodejs";
        $r = run         'apt-get', 'reinstall',  '--yes', "openjdk-17-jdk";
        $r = run         'apt-get', 'reinstall',  '--yes', "openjdk-17-jre";
        $r = run         'apt-get', 'reinstall',  '--yes', "npm";
        $r = run         'apt-get', 'reinstall',  '--yes', "g++";
        chdir($CWD);
    }
}



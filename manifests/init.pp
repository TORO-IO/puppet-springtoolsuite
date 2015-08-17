class springtoolsuite {
	
	$tar_filename = 'spring-tool-suite-3.7.0.RELEASE-e4.5-macosx-cocoa-x86_64.tar.gz'

	exec {"curl_springtoolsuite":
            command => "/usr/bin/curl -O http://dist.springsource.com/release/STS/3.7.0.RELEASE/dist/e4.5/$tar_filename",
            unless  => "test -f /private/tmp/${tar_filename}",
            cwd     => "/private/tmp",
            timeout => 0
    }

	exec {"extract_springtoolsuite":
            command => "/usr/bin/tar -xzf /private/tmp/$tar_filename",
            unless  => "test -d /Applications/springsource",
            cwd     => "/Applications",
            require => Exec["curl_springtoolsuite"],	
    }

	file {"/private/tmp/$tar_filename":
		ensure => absent,
		require => Exec["extract_springtoolsuite"]
	}

}

class php54 {
	file { "/etc/apt/sources.list":
		ensure => file,
		owner => root,
		group => root,
		source => "puppet:///modules/php54/sources.list",
	}
	exec { "import-gpg":
		command => "/usr/bin/wget -q http://www.dotdeb.org/dotdeb.gpg -O -| /usr/bin/apt-key add -"
	}
	
	exec { "/usr/bin/apt-get update":
		require => [File["/etc/apt/sources.list"], Exec["import-gpg"]],
	}
	
	package { [
		"php5"
	] :
		ensure => latest,
		require => Exec["/usr/bin/apt-get update"]
	}
}
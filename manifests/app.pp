# == Define: uwsgi::app
#
# Responsible for creating uwsgi applications. You shouldn't need to use this
# type directly, as the main `uwsgi` class uses this type internally.
#
# === Parameters
#
# [*ensure*]
#    Ensure the config file exists. Default: 'present'
#
# [*template*]
#    The template used to construct the config file.
#    Default: 'uwsgi/uwsgi_app.ini.erb'
#
# [*uid*]
#    The user to run the application as. Required.
#    May be the user name, not just the id.
#
# [*gid*]
#    The group to run the application as. Required.
#    May be the group name, not just the id.
#
# [*application_options*]
#    Extra options to set in the application config file
#
# === Authors
# - Josh Smeaton <josh.smeaton@gmail.com>
#
define uwsgi::app (
    $ensure              = 'present',
    $template            = 'uwsgi/uwsgi_app.ini.erb',
    $application_options = undef,
    $uid,
    $gid
) {

    file { "${::uwsgi::app_directory}/${title}.ini":
        ensure  => $ensure,
        owner   => $uid,
        group   => $gid,
        mode    => '0644',
        content => template($template),
        require => Package[$::uwsgi::package_name],
        notify  => Service[$::uwsgi::service_name]
    }
}

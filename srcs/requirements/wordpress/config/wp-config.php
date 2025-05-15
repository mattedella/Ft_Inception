<?php
define('DB_NAME', getenv('MYSQL_DATABASE'));
define('DB_USER', getenv('MYSQL_USER'));
define('DB_PASSWORD', trim(file_get_contents('/run/secrets/db_password.txt')));
define('DB_HOST', getenv('WP_DB_HOST'));
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

define( 'AUTH_KEY',          'AGZ)L<.2K2G>Im.pk]R,k4=(]*5>;!suoj2AM~:n]h*+3S]i5&,j4skSDq$3~3[s' );
define( 'SECURE_AUTH_KEY',   '1NsrVW]~3vfdpzXy2NTy GqS<8.O?Rmz=lZH%+J&g]WXrYFhghX]zos)R0,S,{dR' );
define( 'LOGGED_IN_KEY',     'f](9J?zXR#Mlsn3n@)/_P(kmH}1_&U:sUN4-aFfG=StNxqrpB)oHGZ9ZWWM>nXsF' );
define( 'NONCE_KEY',         'hj-%}Pa`g4<Q`>|XK1_JX2yZVYqP.H5teo%SCn_5P$mgvV6Y$EU0HO]Xl:9JQMsm' );
define( 'AUTH_SALT',         'Gh=/:5U>6@N/zRxl2G{TQs[/{CbY/hZ/?37RPaO*?<]s@qie+qm[8K{#,,0@]?(]' );
define( 'SECURE_AUTH_SALT',  'mP:bv1<]EFj6iJW}LEoaQEZj$ $l+3VGLa/gO+ 2$];gvGmw82X =a>]00jPlG ;' );
define( 'LOGGED_IN_SALT',    ' |A>+m(-c0MVF7$ 3+aUwfN-+grnl_o$gVS*r*{|EZ%3>N;;]QGhSzfPhAO{Q/*[' );
define( 'NONCE_SALT',        'Az9$(Mg>eN?~?]|=j0TSu9YI|8<pf:dJoM`qo.#*#}#xfPb#^}#w$*PoS;YYoyAJ' );
define( 'WP_CACHE_KEY_SALT', 'blw$*I]q?a9d51>+YuW{m y6o*-_s>@m /e<qEzUwk3P2.1u:2^K^+pT|{yc7>3v' );

$table_prefix = 'wp_';
define('WP_DEBUG', false);

if ( !defined('ABSPATH') )
    define('ABSPATH', dirname(__FILE__) . '/');

require_once(ABSPATH . 'wp-settings.php');

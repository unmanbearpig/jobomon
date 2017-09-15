// inject bundled Elm app into div#main
var Elm = require( '../elm/Main' );
require( './styles/main.scss' );

Elm.Main.embed( document.getElementById( 'main' ) );

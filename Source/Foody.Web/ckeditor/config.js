/**
 * @license Copyright (c) 2003-2016, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function (config) {

    //Default
    config.extraPlugins = 'youtube';
    config.extraPlugins = 'lineutils';
    config.extraPlugins = 'widget';

    //video
    config.extraPlugins = 'oembed,fontawesome,lineheight';
    config.oembed_maxWidth = '560';
    config.oembed_maxHeight = '315';

    //fontawesome    
    config.contentsCss = '/Admin/Components/App/css/font-awesome.min.css';
    config.allowedContent = true;

};

// allow i tags to be empty (for font awesome)
CKEDITOR.dtd.$removeEmpty['span'] = false;
CKEDITOR.dtd.$removeEmpty['i'] = false

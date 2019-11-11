# Pimcore on Docker Trouble Shooting

## Issue: Not able to update MaxMind GeoIP2 database

Most likely you have connectivity issues:

1. You are behind a proxy server.  Sorry can't help you, proxy servers sometimes block access to websites and file types.  Please ask your IT admnistrator to allow access to: http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.mmdb.gz
2. Your internet connection is slow.  By default, network operations in Pimcore's code have a timeout of 5 seconds.  It is likely that you'll need to modify this value in `Pimcore\Tool::getHttpData()` method.  You can find this file under `pimcore/vendor/pimcore/pimcore/lib` directory.

## Issue: After installing pimcore, there are connection issues with /doc-types and other URLs

Pimcore uses ExtJS in order to create data stores for many different resources.  It's likely that your computer is not performing fast enough, so, please modify `pimcore/web/bundles/pimcoreadmin/js/pimcore/startup.js` and look for the string `pimcore.model.docTypes`, you should find it's definition.  Add a timeout property and set it according to your computer's performance, e.g.:


```javascript
    Ext.define('pimcore.model.doctypes', {
        extend: 'Ext.data.Model',
        fields: [
            'id',  {name: 'name', allowBlank: false}, 'module', 'controller', 'action', 'template',
            {name: 'type', allowBlank: false},'priority', 'creationDate', 'modificationDate', 'legacy'
        ],
        proxy: {
            type: 'ajax',
            reader: {
                type: 'json',
                totalProperty: 'total',
                successProperty: 'success',
                rootProperty: 'data'
            },
            writer: {
                type: 'json',
                writeAllFields: true,
                rootProperty: 'data',
                encode: 'true'
            },
            api: {
                create: docTypesUrl + "xaction=create",
                read: docTypesUrl + "xaction=read",
                update: docTypesUrl + "xaction=update",
                destroy: docTypesUrl + "xaction=destroy"
            },                  // <----- don't forget about the comma!!
            timeout: 120000     // <----- this was added!!!
        }
    });
```

Repeat with other data stores as needed.


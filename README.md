# Master NEO (Near Earth Object)

A school flutter project.
Based on the [NASA's NeoWs Open API](https://api.nasa.gov/) and their NASA Image and Video Library API (available at the same location).

The project work on two views:
 - A first one who recover the list of the NEO on the NeoWs NASA's API and display them on an "infinite scroll" view.
 - A second one who display the details as the Orbital informations and recover a list of images onto the NASA's library by researching using the NEO's name.

## Configuration of the project

In order to get the project working, you need to get an API key (freely available) on the NASA openApis website [here](https://api.nasa.gov/).

Once done, create a `.env` file at the base of the working directory and put these into it:
```env
API_KEY=<YOUR API KEY>
```

## Credits

The icons come principaly from the default Icons library of flutter but there is some from tiers party:
 - [Planets Icon Pack](https://iconscout.com/icon-pack/planets-1) on [IconScout](https://iconscout.com)
 - [Orbit Icon](https://iconscout.com/icons/orbit) on [IconScout](https://iconscout.com)
 - [Distance Icon](https://iconscout.com/icons/distance) on [IconScout](https://iconscout.com)

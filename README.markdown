This is the source code for the website [41 Cero 10 Asesores](http://41cero10.org), a company from Seville (Spain).

I had three main goals for the administration of this site.

The first one was that every content on the page could be edited by the adminisitrators. That means that not only the content of the several sections, but also the homepage, the navigation bar, the address and phone number, etc... can be edited.

The second one was to provide an editor friendly enough so users don't prefer using word proccessors and then try copying the contents. Users are more familiar with word processors, so it's natural they tend to use them to edit content. However, [using word processors for webpages is usually a bad idea](http://redcloth.org/articles/wysi-dangerous-why-wysiwyg-editors-are-bad-for-your-website/).

So I provided a couple of features commonly requested: a way to have both a draft and a published version of a page (drafts are automatically created), and a way to properly preview the page at the same time you're editing it. That means the administration section has the same layout as the rest of the website, and live page previews appear just above the form for editing them (which uses Textile syntax). I didn't provide "In-Place editing" because the sites I've seen so far implementing it to edit a whole page are quite messy.

The big drawback of this system is that word processors don't require internet connection; using the web does. And it still doesn't solve the main problem of web editors: users have to learn a new way to edit text. Even if Textile is easier than HTML, and not as messy as WYSIWYG editors, its syntax is mostly unknown. My usability tests show that providing some help and buttons on the editor (using [MarkItUp](http://markitup.jaysalvat.com) still isn't enough, even if live previews make syntax errors easier to detect. To date, I haven't seen a solution other than directly teaching users.

The third goal was managing image attachments as easily as possible. A gallery with thumbnails is shown at the bottom of the form (where you can add new images to the gallery with a single click). You click on a thumbnail, and the image is inserted into the page using Textile syntax. Since we use Dragonfly to generate the images, you can choose the size of the image very easily.

This system has its drawbacks as well. For example, right now captions aren't allowed, although adding a custom Textile tag in RedCloth implementing figure and figcaption could be interesting.

From a technical perspective, the main goal was to experiment with emerging patterns and technologies. The site is built using, among others:

* Ruby 1.9.3.
* Rails 3.1, with the asset pipeline. I found it helped a lot to better organize and make more solid CSS and Javascript code.
* RSpec.
* Capybara.
* CoffeeScript.
* SASS.
* HAML. Although I agree it might not be superior to HTML (if you're writing just HTML), I find it way cleaner than ERB if you're writing Ruby in HTML.
* jQuery.
* [Jasmine](https://github.com/pivotal/jasmine), with [jasminerice](https://github.com/bradphelan/jasminerice). For the first time, I've enjoyed writing and executing JavaScript tests.
* [Draper](https://github.com/jcasimir/draper), an excellent gem that helped me replace some crappy helper code.
* [Decent Exposure](https://github.com/voxdolo/decent_exposure) has helped me organize code and realize that controllers do too many things, though I think there's still room for improvement (maybe using Presenters).
* [XapianDb](https://github.com/garaio/xapian_db), a search gem offering easy and powerful search, spelling suggestions and similar results.
* [Cells](https://github.com/apotonick/cells) has made me realize there's a better way to do partials, but I still find it a bit complex.

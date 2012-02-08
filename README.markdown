This is the source code for the website [41 Cero 10 Asesores](http://41cero10.org), a company from Seville (Spain).

I had three main goals for the administration of this site.

The first one was that every content on the page could be edited by the adminisitrators. That means that not only the content of the several sections, but also the homepage, the navigation bar, the address and phone number, etc... can be edited.

The second one was to provide an editor friendly enough so users don't prefer using word proccessors and then try copying the contents. Users are more familiar with word processors, so it's natural they tend to use them to edit content. However, [using word processors for webpages is usually a bad idea](http://redcloth.org/articles/wysi-dangerous-why-wysiwyg-editors-are-bad-for-your-website/).

So I provided a couple of features commonly requested: a way to have both a draft and a published version of a page (drafts are automatically created), and a way to properly preview the page at the same time you're editing it. That means the administration section has the same layout as the rest of the website, and live page previews appear just above the form for editing them (which uses Textile syntax). I didn't provide "In-Place editing" because the sites I've seen so far implementing it to edit a whole page are quite messy.

The big drawback of this system is that word processors don't require internet connection; using the web does. And it still doesn't solve the main problem of web editors: users have to learn a new way to edit text. Even if Textile is easier than HTML, and not as messy as WYSIWYG editors, its syntax is mostly unknown. My usability tests show that providing some help and buttons on the editor (using [MarkItUp](http://markitup.jaysalvat.com) still isn't enough, even if live previews make syntax errors easier to detect. To date, I haven't seen a solution other than directly teaching users.

The third goal was managing image attachments as easily as possible. A gallery with thumbnails is shown at the bottom of the form (where you can add new images to the gallery with a single click). You click on a thumbnail, and the image is inserted into the page using Textile syntax. Since we use Dragonfly to generate the images, you can choose the size of the image very easily.

This system has its drawbacks as well. For example, right now captions aren't allowed, although adding a custom Textile tag in RedCloth implementing figure and figcaption could be interesting.

The site is built using Ruby 1.9.3, Rails 3.1, RSpec, Capybara, jQuery, Jasmine, CoffeeScript, SASS, HAML and XapianDb, among others.

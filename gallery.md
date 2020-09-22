---
layout: page
title: Galerie
permalink: /gallery/
---

{% for image in site.static_files %}
{% if image.path contains 'img/paintings' %}
<a href="{{ site.baseurl }}{{ image.path }}"><img src="{{ site.baseurl }}{{ image.path }}" alt="{{ image.basename }}"/></a>
{% endif %}
{% endfor %}
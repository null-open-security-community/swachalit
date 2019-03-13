# Markdown Pages

## Requirement

Multiple static pages needs to be created with rich text and images. Different people are responsible for managing these pages.

## Solution

We create a simple page management and publishing functionality consisting of:

* Page
   * Markdown Content
   * Meta-information
      * Published?
      * Name
      * Navigation Name (Entry name in navbar)
      * Slug (read-only - used to access the page by name)
      * Description
      * Tags
* Page Access Permission
   * UserId
   * PageId
   * AccessType

## Story

* Only admin should be able to create a page. However an admin can allow edit/delete access to the page to one or more users in the system. 
* /pages/ URI should list only editable page for a given non-admin user
* Users with editable page permission on a page should be able to edit/update the page
* A published page should be visible to the world


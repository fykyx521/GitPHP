{*
 * Main
 *
 * Main page template
 *
 * @author Christopher Han <xiphux@gmail.com>
 * @copyright Copyright (c) 2011 Christopher Han
 * @packge GitPHP
 * @subpackage Template
 *}
{'<?xml version="1.0" encoding="utf-8"?>'}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
  <!-- gitphp web interface {$version}, (C) 2006-2011 Christopher Han <xiphux@gmail.com> -->
  <head>
    <title>{$pagetitle}{if $project} :: {$project->GetProject()}{if $actionlocal}/{$actionlocal}{/if}{/if}</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    {if $project}
      <link rel="alternate" title="{$project->GetProject()} log (Atom)" href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=atom" type="application/atom+xml" />
      <link rel="alternate" title="{$project->GetProject()} log (RSS)" href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=rss" type="application/rss+xml" />
    {/if}
    {if file_exists('css/gitphp.min.css')}
    <link rel="stylesheet" href="css/gitphp.min.css" type="text/css" />
    {else}
    <link rel="stylesheet" href="css/gitphp.css" type="text/css" />
    {/if}
    {if file_exists("css/$stylesheet.min.css")}
    <link rel="stylesheet" href="css/{$stylesheet}.min.css" type="text/css" />
    {else}
    <link rel="stylesheet" href="css/{$stylesheet}.css" type="text/css" />
    {/if}
    <link rel="stylesheet" href="css/ext/jquery.qtip.css" type="text/css" />
    {if $extracss}
    <style type="text/css">
    {$extracss}
    </style>
    {/if}
    {if $javascript}
    <script src="js/ext/require.js"></script>
    {include file='jsconst.tpl'}
    <script type="text/javascript">
    require({ldelim}
    	baseUrl: 'js',
	paths: {ldelim}
	{if $extrascripts}
	  {if file_exists("js/$extrascripts.min.js")}
	  	{$extrascripts}: "{$extrascripts}.min",
	  {/if}
	{else}
	  {if file_exists('js/common.min.js')}
	  	common: "common.min",
	  {/if}
	{/if}
	{if $googlejs}
		jquery: 'https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min'
	{else}
		jquery: 'ext/jquery-1.7.1.min'
	{/if}
	{rdelim},
	priority: ['jquery']
    {rdelim}, [
    	{if $extrascripts}
	  '{$extrascripts}'
	{else}
	  'common'
	{/if}
      ]);
    </script>
    {/if}
  </head>
  <body>
    <div class="page_header">
      <a href="http://git-scm.com" title="git homepage">
        <img src="images/git-logo.png" width="72" height="27" alt="git" class="logo" />
      </a>
      {if $supportedlocales}
      <div class="lang_select">
        <form action="{$SCRIPT_NAME}" method="get" id="frmLangSelect">
         <div>
	{foreach from=$requestvars key=var item=val}
	{if $var != "l"}
	<input type="hidden" name="{$var}" value="{$val}" />
	{/if}
	{/foreach}
	<label for="selLang">{t}language:{/t}</label>
	<select name="l" id="selLang">
	  {foreach from=$supportedlocales key=locale item=language}
	    <option {if $locale == $currentlocale}selected="selected"{/if} value="{$locale}">{if $language}{$language} ({$locale}){else}{$locale}{/if}</option>
	  {/foreach}
	</select>
	<input type="submit" value="{t}set{/t}" id="btnLangSet" />
         </div>
	</form>
      </div>
      {/if}
      <a href="index.php">{if $homelink}{$homelink}{else}{t}projects{/t}{/if}</a> / 
      {if $project}
        <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=summary">{$project->GetProject()}</a>
        {if $actionlocal}
           / {$actionlocal}
        {/if}
        {if $enablesearch}
          <form method="get" action="index.php" enctype="application/x-www-form-urlencoded">
            <div class="search">
              <input type="hidden" name="p" value="{$project->GetProject()}" />
              <input type="hidden" name="a" value="search" />
              <input type ="hidden" name="h" value="{if $commit}{$commit->GetHash()}{else}HEAD{/if}" />
              <select name="st">
                <option {if $searchtype == 'commit'}selected="selected"{/if} value="commit">{t}commit{/t}</option>
                <option {if $searchtype == 'author'}selected="selected"{/if} value="author">{t}author{/t}</option>
                <option {if $searchtype == 'committer'}selected="selected"{/if} value="committer">{t}committer{/t}</option>
                {if $filesearch}
                  <option {if $searchtype == 'file'}selected="selected"{/if} value="file">{t}file{/t}</option>
                {/if}
              </select> {t}search{/t}: <input type="text" name="s" {if $search}value="{$search}"{/if} />
            </div>
          </form>
        {/if}
      {/if}
    </div>
{block name=main}

{/block}
    <div class="page_footer">
      {if $project}
        <div class="page_footer_text">
	{if $project->GetWebsite()}
	<a href="{$project->GetWebsite()}">{$project->GetDescription()}</a>
	{else}
	{$project->GetDescription()}
	{/if}
	</div>
        <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=rss" class="rss_logo">{t}RSS{/t}</a>
        <a href="{$SCRIPT_NAME}?p={$project->GetProject()|urlencode}&amp;a=atom" class="rss_logo">{t}Atom{/t}</a>
      {else}
        <a href="{$SCRIPT_NAME}?a=opml" class="rss_logo">{t}OPML{/t}</a>
        <a href="{$SCRIPT_NAME}?a=project_index" class="rss_logo">{t}TXT{/t}</a>
      {/if}
    </div>
    <div class="attr_footer">
    	<a href="http://xiphux.com/programming/gitphp/" target="_blank">GitPHP by Chris Han</a>
    </div>
  </body>
</html>
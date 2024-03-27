def includeme(config):
    config.add_static_view('static', 'static', cache_max_age=3600)
    config.add_static_view('staticSiteGraphics', 'static/siteGraphics', cache_max_age=3600)

    config.add_route('home', '/')
    
    config.add_route('userlogin', '/userlogin')
    config.add_route('logout', '/logout')
    config.add_route('viewTrees', '/viewTrees')

    config.add_route('addTree', '/addTree')
    config.add_route('addTreeInsert', '/addTreeInsert')
    
    config.add_route('treeViewDetermine', '/treeViewDetermine')
    config.add_route('smallTreeView', '/smallTreeView')
    config.add_route('viewTreeAsList', '/viewTreeAsList')
    

    config.add_route('tallWideTreeView', '/tallWideTreeView')
    config.add_route('tallWideTreeViewGetJson', '/tallWideTreeViewGetJson')
    
    config.add_route('personProfileViewC', '/personProfileViewC')

    config.add_route('selectRelTypeToAdd', '/selectRelTypeToAdd')
    config.add_route('addPerson', '/addPerson')
    config.add_route('addPersonCommit', '/addPersonCommit')

    config.add_route('addPerson02', '/addPerson02')

    config.add_route('deletePerson', '/deletePerson')
        
    
    config.add_route('updatePerson', '/updatePerson')  
    config.add_route('updatePersonCommit', '/updatePersonCommit')

   
    

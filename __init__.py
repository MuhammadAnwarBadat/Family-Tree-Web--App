from pyramid.authentication import AuthTktAuthenticationPolicy
from pyramid.authorization import ACLAuthorizationPolicy

from pyramid.config import Configurator

# from .security import groupfinder
# from .security import groupfinder

from .views.security import groupfinder


def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    """
    config = Configurator(settings=settings, root_factory='.resources.Root')
	# with Configurator(settings=settings) as config:
    config.include('pyramid_mako')
    config.include('.routes')
	# config.include('.views')

    # Security policies
    authn_policy = AuthTktAuthenticationPolicy(
        settings['kw03.secret'], callback=groupfinder,
        hashalg='sha512')
    authz_policy = ACLAuthorizationPolicy()
    config.set_authentication_policy(authn_policy)
    config.set_authorization_policy(authz_policy)
	
	# config.scan('.start')
    config.scan()
    return config.make_wsgi_app()

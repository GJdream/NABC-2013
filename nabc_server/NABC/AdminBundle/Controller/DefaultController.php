<?php

namespace NABC\AdminBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
    public function indexAction($name)
    {
        return $this->render('NABCAdminBundle:Default:index.html.twig', array('name' => $name));
    }
}

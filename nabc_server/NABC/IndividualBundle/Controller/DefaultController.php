<?php

namespace NABC\IndividualBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
    public function indexAction($name)
    {
        return $this->render('NABCIndividualBundle:Default:index.html.twig', array('name' => $name));
    }
}

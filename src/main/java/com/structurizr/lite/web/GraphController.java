package com.structurizr.lite.web;


import com.structurizr.lite.Configuration;
import com.structurizr.lite.component.workspace.WorkspaceMetaData;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class GraphController extends AbstractController {

    @RequestMapping(value = "/workspace/explore/graph", method = RequestMethod.GET)
    public String showDocumentation(@RequestParam(required = false, defaultValue = "") String view, ModelMap model) {
        WorkspaceMetaData workspaceMetaData = new WorkspaceMetaData();
        workspaceMetaData.setEditable(false);
        workspaceMetaData.setApiKey(Configuration.getInstance().getApiKey());
        workspaceMetaData.setApiSecret(Configuration.getInstance().getApiSecret());

        addCommonAttributes(model, "Structurizr Lite", true);
        model.addAttribute("showFooter", false);
        model.addAttribute("workspace", workspaceMetaData);
        model.addAttribute("urlPrefix", "/workspace");

        model.addAttribute("type", "graph");
        model.addAttribute("view", view);

        return "graph";
    }

}
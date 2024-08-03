import 'package:football/presentation/home/pages/home_pages/pages/calendar_pages/calendar_page.dart';
import 'package:football/presentation/home/pages/home_pages/pages/leagues_page.dart';
import 'package:football/presentation/home/pages/home_pages/pages/my_team_page.dart';
import 'package:football/presentation/home/pages/home_pages/pages/points_page.dart';
import 'package:football/presentation/home/pages/home_pages/pages/transfer_page.dart';
import 'package:football/presentation/home/pages/settings_pages/pages/notification_page.dart';
import 'package:football/presentation/home/pages/settings_pages/pages/profile_page.dart';

import '../../presentation/home/pages/settings_pages/pages/intro_page.dart';

const intro = [
  {
    'image': "assets/images/intro/intro_img_1.png",
    "title": "Futbol o'yini",
    "text": "Professional liga futbol uchrashuvlarini tomosha qiling va o’ynang"
  },
  {
    'image': "assets/images/intro/intro_img_2.png",
    "title": ""
        "Real vaqt statistikasi",
    "text":
        "105 mln ga 15 nafar uyinchini sotib oling va ularning xakikiy uyinlardagi xarakatlari uchun ochkolarni kulga kiriting. Xush, orzuingizdagi jamoaga kimlarni olasiz?"
  },
  {
    'image': "assets/images/intro/intro_img_3.png",
    "title": "Liga turnir jadvali",
    "text": "Butun dunyo bo'ylab klublar statistikasi va ligadagi holati"
  },
];

const List bottomNavigation = [
  {"image": "assets/images/bottom_navigation/home_bottom.png", "label": "Home"},
  {
    "image": "assets/images/bottom_navigation/balance_bottom.png",
    "label": "Balance"
  },
  {
    "image": "assets/images/bottom_navigation/statistics_bottom.png",
    "label": "Statistics"
  },
  {
    "image": "assets/images/bottom_navigation/settings_bottom.png",
    "label": "Settings"
  },
];

const List homeMenuItems = [
  {
    "image": "assets/images/home/m_points_img.png",
    "label": "Ochkolar",
    "rout": PointsPage()
  },
  {
    "image": "assets/images/home/m_team_img.png",
    "label": "Mening Jamoam",
    "rout": MyTeamPage()
  },
  {
    "image": "assets/images/home/m_taqvim_img.png",
    "label": "Taqvim",
    "rout": CalendarPage()
  },
  {
    "image": "assets/images/home/m_transfer_img.png",
    "label": "Transfer",
    "rout": TransferPage()
  },
  {
    "image": "assets/images/home/m_leagues_img.png",
    "label": "Ligalar",
    "rout": LeaguesPage()
  },
];

const List settingMenuItems = [
  {
    "image": "assets/images/settings/language_img.png",
    "label": "Tilni Tanlang",
    "rout": ""
  },
  {
    "image": "assets/images/settings/intro_img.png",
    "label": "Tanishtiruv",
    "rout": IntroPage()
  },
  {
    "image": "assets/images/settings/profile.png",
    "label": "Profile",
    "rout": ProfilePage()
  },
  {
    "image": "assets/images/settings/notification_img.png",
    "label": "Bildirishnomalar",
    "rout": NotificationPage()
  },
  {
    "image": "assets/images/settings/share_img.png",
    "label": "Ilovani ulashish",
    "rout": ""
  },
  {
    "image": "assets/images/settings/invite_friends_img.png",
    "label": "Do'stlarni taklif qiling",
    "rout": ""
  },
];

var tactics = [
  [1, 3, 4, 3],
  [1, 3, 5, 2],
  [1, 4, 5, 1],
  [1, 4, 4, 2]
];

var tacticsString = ['1-3-4-3', '1-3-5-2', '1-4-5-1', '1-4-4-2'];

Map<int, String> reversePosition = {
  0: "goalkeeper",
  1: "defender",
  2: "midfielder",
  3: "forward",
};

const intro_text = """
Welcome to Fantasy Football Hub. If you continue to browse and use this website you are agreeing to comply with and be bound by the following terms and conditions of use, which together with our privacy policy govern Fantasy Football Hub Ltd’s relationship with you in relation to this website.

The term ‘Fantasy Football Hub Ltd’ or ‘us’ or ‘we’ refers to the owner of the website whose registered office is Preston Park House, South Road, Brighton BN1 6SB. Our company registration number is 11545808 and is Registered in England and Wales. The term ‘you’ refers to the user or viewer of our website.

These terms and conditions of use (“Terms”) apply to your use of the Website and by continuing to use this Website you are confirming that you accept the Terms set out below and the additional usage terms set out in the relevant parts of the Website.

The use of this website is subject to the following General Terms and Conditions:

The content of the pages of this website is for your general information and use only. It is subject to change without notice.
Neither we nor any third parties provide any warranty or guarantee as to the accuracy, timeliness, performance, completeness or suitability of the information and materials found or offered on this website for any particular purpose. You acknowledge that such information and materials may contain inaccuracies or errors and we expressly exclude liability for any such inaccuracies or errors to the fullest extent permitted by law.
We do not warrant that functions available on this website will be uninterrupted or error free, that defects will be corrected, or that the server that makes it available is free of viruses or bugs. You acknowledge that it is your responsibility to implement sufficient procedures and virus checks (including anti-virus and other security checks) to satisfy your particular requirements for the accuracy of data input and output.
Your use of any information or materials on this website is entirely at your own risk, for which we shall not be liable. It shall be your own responsibility to ensure that any products, services or information available through this website meet your specific requirements.
This website contains material which is owned by or licensed to us. This material includes, but is not limited to, the design, layout, look, appearance and graphics. Reproduction is prohibited other than in accordance with the copyright notice, which forms part of these terms and conditions.
All trademarks reproduced in this website, which are not the property of, or licensed to the operator, are acknowledged on the website.
Unauthorised use of this website may give rise to a claim for damages and/or be a criminal offence.
From time to time this website may also include links to other websites. These links are provided for your convenience to provide further information. They do not signify that we endorse the website(s). We have no responsibility for the content of the linked website(s) and accept no responsibility for them or for any loss or damage that may arise from your use of them.
Your use of this website and any dispute arising out of such use of the website is subject to the laws of England, Scotland and Wales.
We may revise these terms of use at any time by amending this page. You are expected to check this page from time to time to take notice of any changes made, as they are binding on you. Some of the provisions contained in these terms and conditions may also be superseded by provisions or notices published elsewhere on our site.
1. REGISTRATION AND YOUR ACCOUNT
1.1. While this site is accessible without a registered account, in order to participate in and contribute to the Fantasy Football Hub community you will:

1.1.1. be required to register with the site;

1.1.2. be 18 or over to register for an account;

1.2. You need to select or accept a password to access your account. You agree not to reveal your password to other users as your Account is at risk if you let someone use it inappropriately.

1.3. It may be necessary for us to refuse some registration applications for example to prevent fraudulent use of the Website.

1.4. Maintaining the security and integrity of the Website is necessary to enable all our users to use it safely and effectively.

You agree:

1.4.1. not to abuse the access or registration process;

and

1.4.2. to take responsibility for any improper or illegal use of your Account (including illegal or improper use by a third party who has used your password to access your Website Account) and repay to us with any costs and/or losses that we suffer as a result.

1.5. Any personal information supplied to Fantasy Football Hub Ltd as part of this registration process and/or any other interaction with cms.fantasyfootballhub.co.uk will be collected, stored and used in accordance with the Fantasy Football Hub Privacy Policy.

1.6. If you use multiple logins for the purpose of disrupting a community or annoying other users you may have action taken against all of your accounts.

1.7. All accounts must be registered with a valid personal email address that you access regularly. Accounts registered with someone else’s email address, or with temporary email addresses may be closed without notice.

1.8. Fantasy Football Hub reserves the right to close accounts if any user is seen to be using proxy IPs (Internet Protocol addresses) in order to attempt to hide the use of multiple Fantasy Football Hub accounts.

1.9. These Terms shall continue to apply to your use of the Website generally, however you may decide to close your Account. You may do so by notifying us at any time by sending an email stating such to us at support@fantasyfootballhub.co.uk.

2. PAYMENT TERMS
2.1 Membership Subscriptions

2.1.1 To begin a subscription, you must provide us with one or more Payment Methods. “Payment Method” means a current, valid, accepted method of payment, as may be updated from time to time and which may include payment through your account with a third party.

2.1.2 Your subscription will continue and automatically renew until terminated. You must cancel your membership before it renews in order to avoid account charges for the next billing cycle.

2.1.3 Account charges are fully earned upon payment and there are no refunds or credits for partially used months or years, as applicable.

2.1.4 If any fee is not paid in a timely manner, or Fantasy Football Hub Ltd is unable to process your transaction using the credit card information provided, Fantasy Football Hub Ltd reserves the right to revoke access to your account.

2.1.5 If your credit card reaches its expiration date, your continued use of Fantasy Football Hub constitutes your authorisation for us to continue billing that credit card and you remain responsible for any uncollected amounts. It is your responsibility to keep your contact information and payment information current and updated.

2.1.6 You can find specific details regarding your subscription to Fantasy Football Hub by visiting your account page.

2.2 Auto-Renewal for Subscriptions

2.2.1 Your Subscription will be automatically renewed at the end of each Subscription Term and your Payment Method (defined above) will be charged for the next Subscription Term.

2.2.2 If you wish to cancel auto-renewal of your Subscription for the following Subscription Term, you must cancel your plan through your account page or through the App Store you used for purchase at least one (1) day prior to the end of your then-current Subscription Term.

2.2.3 Fantasy Football Hub may change the Subscription Fee upon notice to you, but such change will only take effect once your then-current Subscription Term has ended.

2.2.4 If you do not wish to pay the new Subscription Fee, your only remedy will be to cancel your Subscription for the following Subscription Term, prior to the expiration of your then-current Subscription Term.

2.3 Cancellation; No Refunds

2.3.1 You may cancel your Subscription at any time on your account page; however, there are no refunds for cancellation.

2.3.2 If you cancel before the end of your Subscription Term you will have access to your account for the remainder of the Subscription Term.

2.3.3 If you signed up for a Subscription through the iOS App Store or Google Play store, you must cancel or change your Subscription via the applicable app stores.

2.3.4 In the event that Fantasy Football Hub suspends or terminates your account for your breach of these terms, you acknowledge and agree that you will receive no refund or exchange for any unused time on a Subscription, any Subscription Fees for any portion of the Services, any Content associated with your account, or for anything else.

2.4 Billing

2.4.1 We use a third-party payment processor (the “Payment Processor”) to bill you through a payment account linked to your account on the Services (your “Billing Account”) for your Subscription Fees.

2.4.2 The processing of payments will be subject to the terms, conditions, and privacy policies of the Payment Processor in addition to these Terms. We are not responsible for error by the Payment Processor.

2.4.3 By signing up for a Subscription, you agree to pay us, through the Payment Processor, all charges at the prices then in effect for such Subscription in accordance with the applicable payment terms, and you authorise us, through the Payment Processor, to charge your chosen payment provider (for example, a credit or debit card you provide) (your “Payment Method”).

2.4.4 You agree to make payment using that selected Payment Method.

2.4.5 We reserve the right to correct any errors or mistakes that the Payment Processor makes even if it has already requested or received payment.

2.4.6 Currently, we use Stripe, Inc. and PayPal as our Payment Processors although we are not currently offering PayPal payments to new customers. You can access Stripe’s Terms of Service at https://stripe.com/us/checkout/legal and their Privacy Policy at https://stripe.com/us/privacy.

2.5 Pricing

Fantasy Football Hub reserves the right to adjust pricing for our Services or any components thereof in any manner and at any time, as we may determine in our sole and absolute discretion.

2.6 ‘Win Your FPL Mini-League or Your Money Back’ Offer

In order to be eligible for any refund referring to our ‘Win your FPL Mini-League or your Money Back’ offer, you must:
2.6.1. Be a new paying Fantasy Football Hub subscriber as of the 2023/24 season.

2.6.2 Give us the FPL ID code of the league you’d like to win (this can be found in the URL when viewing that league). Email fpl@fantasyfootballhub.co.uk with the league code as the subject line by September 30th 2023. This league must not have more than 100 participants.

2.6.3 Login and use the site or app every Gameweek during the 23/24 season (from when you become a paying member).

2.6.4 To make a claim, please email support@fantasyfootballhub.co.uk

2.7 Free Trials

2.7.1 Your subscription to Fantasy Football Hub Ltd may begin with a free trial. The duration of the free trial period of your subscription will be specified during sign-up and is intended to allow new and first-time subscribers to try our Services.

2.7.2 Trials require at least one valid Payment Method associated with your account.

2.7.3 Free trial eligibility is determined by Fantasy Football Hub at its sole discretion and we may limit eligibility or duration to prevent free trial abuse. We reserve the right to revoke the free trial and put your account on hold in the event that we determine that you are not eligible.

2.7.4 For combinations with other offers, restrictions may apply. A temporary authorisation may be placed on the credit card to assess its validity. This authorisation will be removed after 24-48 hours, but may vary by bank.

2.7.5 We will charge the subscription fee for your next billing cycle to your Payment Method at the end of the free trial period and your subscription will automatically renew unless you cancel your subscription prior to the end of the free trial period.

To view the applicable subscription price and end date of your free trial period, visit our website and click your account page.

2.7.6 Once a charge is made, there is no refund available and the account is treated a subscription.

2.8 Referrals and Promotions

2.8.1 From time to time, we may offer referral programs for our subscribers, which allow subscribers to earn promotional items by referring friends to become new users of Fantasy Football Hub. To participate, you must agree to these terms, which become part of Fantasy Football Hub Terms of Service. The requirements for receiving, and the amounts of, referral benefits are subject to change at Fantasy Football Hub’s sole discretion.

2.8.2 Fantasy Football Hub has, in its sole discretion, the right to limit the number of times you may use or share your referral code. Your referral code may only be used for personal and non-commercial purposes. This means that you can only share your referral code with people you know. As a result, you agree that you will not (i) duplicate, sell or transfer your referral code in any manner or make it available to the general public, or use paid social media or paid search, (ii) try to use automated systems or bots through any channel to distribute, post or otherwise share your referral code.

2.8.3 Subscribers can earn referral benefits if (i) a referred friend clicks on their referral link to create a valid Fantasy Football Hub account that complies with our Terms of Service and (ii) the referred friend signs up for an annual subscription. Referral benefits are discretionary and the amount of a referral benefit and the requirements can vary.

2.8.4 Fantasy Football Hub may offer discounted promotions and subscriptions from time to time. Unless otherwise noted, the promotional price is available for the first year and for first-time subscribers only, after which regular pricing for the applicable plan will apply. We reserve the right to withdraw or deactivate any promotion for any reason at any time.

3 TERMINATION OF YOUR ACCOUNT
3.1. We may at any time, terminate your Website Account if:

3.1.1. you have breached any provision of these Terms or our Community Rules any other additional usage terms on this Website (or acted in such a manner which indicates that you cannot or do not intend to comply with these Terms or Community Rules or any other additional usage terms on this Website);

3.1.2. we decide to no longer provide an area on the Website for users to interact;

3.1.3. we are required to do so by law;

3.1.4. despite our reasonable endeavours, we are unable to verify or authenticate any information you provide to us;

3.1.5. we no longer want to offer this service to you.

4. OUR LIABILITY
4.1. The information contained in this website is for general information purposes only. The information is provided by Fantasy Football Hub Ltd and while we endeavour to keep the information up to date and correct, we make no representations or warranties of any kind, express or implied, about the completeness, accuracy, reliability, suitability or availability with respect to the website or the information, products, services, or related graphics contained on the website for any purpose. Any reliance you place on such information is therefore strictly at your own risk.

4.2. Subject to clause 3.3 below, we shall not be liable to you for:

4.2.1. any indirect or consequential losses which may be incurred by you. This shall include any loss of profit (whether incurred directly or indirectly), any loss of goodwill or business reputation, or any loss of business data suffered by you;

4.2.2. any loss or damage which is not reasonably foreseeable;

4.2.3. any loss or damage which may be incurred by you as a result of:

4.2.3.1. any changes that we make to the Website, or for any permanent or temporary cessation in the provision of the Website or any part of it;

4.2.3.2. the deletion of, corruption of, or failure to store any Submissions (and other data) maintained or transmitted by or through your use of the Website;

4.2.3.3. the availability of or result through reliance on, any third party websites accessed through hyperlinks in the Website (including goods and services supplied or made available through such third party websites);

4.2.3.4. your failure to provide us with accurate registration information;

or

4.2.3.5. your failure to keep your password or Account (as defined in clause 1.1) details secure and confidential, or your inclusion of any personal information within a Submission (as defined in clause 15.1).

4.2.4. The limitations on our liability to you in paragraph 3.2.3 shall apply whether or not we have been advised of the possibility of such losses arising in advance.

4.3. We do not limit or exclude our liability for death or personal injury resulting from our negligence, fraudulent misrepresentation or any other losses which may not be lawfully excluded or limited by law.

4.4. Nothing in these terms shall affect your statutory rights. If you have any doubts as to your statutory rights then you should contact your Local Citizens Advice Bureau or refer to the Office of Fair Trading website (www.oft.gov.uk/default.htm).

5. YOUR LIABILITY
5.1. You agree to refund or otherwise take responsibility for any and all liabilities, costs and expenses, including reasonable legal fees, which we or any of our group companies or personnel may incur as a result of to any breach of these Terms by you, or in connection with the use of the Website or any Submission or other transmission of any message or information on the Website by you from your Account.

6. USE OF WEBSITE CONTENT
6.1. All content provided on the Website, our app, and other platforms by us or on our behalf, including text, photographs, images, graphics, illustrations, sounds, videos, designs, written materials, and other elements, is protected by copyright, trademark rights, and/or other intellectual property rights owned by or licensed to Fantasy Football Hub Ltd.

6.2. You are permitted to download, print, or copy any content from the Website, app, or other platforms, provided that you:

6.2.1. Do so only for your personal, non-commercial use;

6.2.2. Acknowledge us as the source of the material; and

6.2.3. Do not use the Fantasy Football Hub content in any other manner.

6.3. For any use of the Fantasy Football Hub content beyond what is set out in clause 6.2, you must obtain prior written consent from us by contacting support@fantasyfootballhub.co.uk.

6.4. We reserve the right to grant or withhold consent for any other uses of the Fantasy Football Hub content at our discretion.

6.5. Certain Fantasy Football Hub content, such as parts of our members area or content supplied by our partners, may be subject to additional usage terms, which will be indicated on the relevant parts of the Website, app, or other platforms.

6.6. Prohibition of Data Scraping and Model Training

6.6.1. Unauthorised Access: Any access to our services, platforms, or data beyond what is explicitly permitted is strictly prohibited. This includes automated access methods such as bots, scripts, or any other technological means designed to extract data from our website, app, or services without prior written consent from us.

6.6.2. Prohibition on Data Scraping: Users are strictly prohibited from using any form of data scraping, crawling, or similar automated processes to extract, harvest, or collect any information or data from our website, app, services, or proprietary AI models. This includes extracting data for personal use, commercial purposes, or redistribution.

6.6.3. Prohibition on Model Training: Users are strictly prohibited from using any data, content, or information from our website, app, services, or proprietary AI models to train, develop, or improve any machine learning models, AI systems, or any other
""";
